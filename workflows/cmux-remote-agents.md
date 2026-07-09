# cmux as the Agent Terminal (+ Persistent Remote Sessions)

[cmux](https://cmux.com) is a native macOS terminal built on libghostty, designed for running many AI coding agents in parallel: vertical workspace tabs, notification rings when an agent needs attention, session resume, and a socket/CLI API for automation. This doc covers the working configuration: harness integration, sidebar behavior, per-harness color coding, and a pattern for one-click persistent agent sessions on a remote host with live titles.

Throughout, `remotehost` is a placeholder for an always-on machine reachable over SSH (e.g. a Mac mini on Tailscale).

## 1. Harness hooks and session resume

cmux resumes supported agents across app relaunches by capturing each agent's native session ID and re-running its resume command (`claude --resume`, `codex resume`, `grok -r`, `agy --conversation`, ...). One-time setup:

```bash
cmux hooks setup        # installs integrations for every supported agent on PATH
```

- Hook configs land in each agent's own config (`~/.codex/hooks.json`, `~/.grok/hooks/`, `~/.gemini/settings.json`, etc.). Claude Code needs no files: cmux injects a wrapper via a PATH shim per surface.
- Runtime session mappings live in `~/.cmuxterm/<agent>-hook-sessions.json`.
- Hooks are guarded by `CMUX_SURFACE_ID`, so they no-op outside cmux (plain Ghostty, SSH, cron).

cmux reads your existing Ghostty config (`~/.config/ghostty/config`) for fonts/theme/opacity. It loads the **first** config file it finds and stops, unlike Ghostty which merges both locations.

> **Do not put cmux-only keys in the Ghostty config.** cmux's docs show `sidebar-font-size` and `surface-tab-bar-font-size` living in `~/.config/ghostty/config`, but Ghostty 1.3.2 rejects unknown fields and throws a config error on every launch. Worse, cmux reads those two keys from its own private file and ignores the Ghostty copy, so you get the error *and* no effect. Set them through cmux, which writes `~/Library/Application Support/com.cmuxterm.app/config.ghostty`:
>
> ```bash
> cmux config set sidebar-font-size 13
> cmux config set surface-tab-bar-font-size 11
> ```
>
> `split-divider-color` **is** a real Ghostty key and can stay in the shared config. Check your work with `ghostty +validate-config`.

## 2. Sidebar behavior settings that matter

Two independent switches both reorder the sidebar; if you navigate by `Cmd+1-8` positions, turn both off (`~/.config/cmux/cmux.json`):

```jsonc
{
  "app": {
    "iMessageMode": false,          // reorder on prompt SEND
    "reorderOnNotification": false  // reorder on notification RECEIVED
  }
}
```

Other settings worth a decision: `terminal.agentHibernation` (kills idle background agent processes to free RAM/CPU, resumes them with state when visited; enable if you run many agents), Sparkle auto-update (cmux ships several releases a week), and `app.openMarkdownInCmuxViewer` (Cmd-click `.md` opens a rendered live-reload viewer).

Reload any config change live with `cmux reload-config` (covers both cmux.json and Ghostty config).

## 3. Color-code workspaces by harness

Workspace rows in the left sidebar take a color. Shell wrappers set it automatically at launch, so you can tell which harness lives in which workspace without clicking in:

```zsh
# ~/.zshrc -- no-op outside cmux
_cmux_ws_color() { [ -n "$CMUX_SURFACE_ID" ] && command cmux workspace-action --action set-color --color "$1" >/dev/null 2>&1; }
claude() { _cmux_ws_color Orange;  command claude "$@"; }
codex()  { _cmux_ws_color Teal;    command codex "$@"; }
grok()   { _cmux_ws_color Crimson; command grok "$@"; }
agy()    { _cmux_ws_color Aqua;    command agy "$@"; }
```

Colors are workspace-level only; horizontal surface tabs can only be renamed.

## 4. What session restore actually does

Most of the confusion around this setup comes from guessing at this, so state it precisely.

`terminal.autoResumeAgentSessions` defaults to `true` and fires whenever **cmux reopens, however it reopens**. Adding cmux to Login Items is *not* required for resume; it only decides whether cmux relaunches without you asking. (Verify it yourself: reboot, launch cmux by hand, then `pgrep -fl claude` shows the resumed processes carrying `--resume <id>`.)

cmux writes a snapshot to `~/Library/Application Support/cmux/session-com.cmuxterm.app.json`. Read it. Every surface either has a `resumeBinding` or it does not:

- **Agent surfaces** carry `terminal.agent.kind` plus a `resumeBinding`, and come back on their prior conversation.
- **Everything else** (`resumeBinding: null`) reopens as a plain shell. Per cmux's own docs: *"tmux, vim, shells, and unsupported terminal apps reopen as normal terminals unless they have their own cmux resume integration."*

That second bullet is what makes the obvious remote-session pattern fail.

## 5. One-click persistent remote sessions (group + button)

Goal: a workspace group named after the remote host whose **+ button** opens a persistent tmux session on that host, and that comes back on its own after a network drop, a cmux quit, or a reboot.

### The wrong way, and how to recognize it

Creating the workspace with a raw command is the obvious move, and it is a trap:

```bash
# DON'T
cmux new-workspace --command "ssh -t remotehost \"tmux attach -t '=$name'\""
```

cmux records that surface as:

```
isRemoteTerminal : false
terminal.command : null          # the ssh command is NOT persisted
resumeBinding    : null          # nothing to replay
workingDirectory : /Users/you    # your LAPTOP's home, not the remote's
```

cmux has no idea a remote host is involved. The tmux session does survive on the remote (that is tmux's doing, not cmux's), but the window into it dies on every relaunch, and you get none of cmux's remote machinery.

### The right way

```bash
cmux ssh remotehost --name "$name" \
  --ssh-option RequestTTY=force \
  --ssh-option "SetEnv=LC_CMUX_TMUX=$name"
```

Two things make this work.

**`cmux ssh` marks the workspace `isRemoteTerminal=true`.** That flag is what gates cmux's remote features: injected keepalives (`ServerAliveInterval=20`, `ServerAliveCountMax=2`, only if your `ssh_config` doesn't set them), capped exponential-backoff reconnect (3s, 6s, 12s, up to 60s), and the `cmuxd-remote` relay (remote `cmux notify` lights up the local sidebar, scp drag-and-drop, browser panes egressing from the remote's network). You can confirm the reconnect: `kill -9` the ssh pid and cmux reattaches by itself. **Any hand-rolled reconnect loop is redundant.**

**The tmux attach rides along in `SetEnv`.** cmux persists `remote.destination` and `remote.sshOptions` in its snapshot, but **not** a trailing remote command. Passing the session name as an env var means it survives restore, and the remote shell does the attach. Add this to the remote's `~/.zshrc`:

```zsh
# Guarded: interactive shells only, never nests inside an existing tmux.
if [[ -o interactive ]] && [[ -n "$LC_CMUX_TMUX" ]] && [[ -z "$TMUX" ]]; then
  exec tmux new-session -A -s "$LC_CMUX_TMUX" -c ~/dev
fi
```

`new-session -A` attaches if the session exists and creates it otherwise, so one command covers both opening and reopening. Use the `LC_` prefix: it is the only one macOS sshd accepts by default (`AcceptEnv LANG LC_*`), and a plain `CMUX_TMUX` is silently dropped with no error.

### Why not the documented resume binding

`cmux surface resume set --kind tmux --checkpoint work --shell "tmux attach -t work"` looks like the official answer. It stores the binding, then reports:

```json
{ "approval_policy": "manual", "auto_resume": false }
```

It will not run until you approve the command prefix under **Settings > Terminal > Resume Commands**, and there is no CLI to approve it. The `SetEnv` approach skips the manual step entirely.

### cmux.json wiring

The action must be `"type": "command"`, not `"workspaceCommand"`. A workspaceCommand surface can only be a **local** terminal, which is exactly the broken shape above. The script calls `cmux ssh` itself; the launcher tab exits after.

```jsonc
{
  "actions": {
    "remote-new": {
      "type": "command",
      "title": "New Remote Session",
      "subtitle": "Persistent tmux session on remotehost",
      "command": "cmux-remote-new",
      "target": "newTabInCurrentPane",
      "keywords": ["remote", "ssh", "tmux"],
      "icon": { "type": "symbol", "name": "server.rack" }
    }
  },
  "workspaceGroups": {
    "byCwd": { "*": { "contextMenu": [ { "action": "remote-new", "title": "New Remote Session" } ] } }
  }
}
```

`~/.local/bin/cmux-remote-new` wraps the `cmux ssh` call, then files the new workspace into the remote-host group via `workspace.group.add` (member-add only, never `group.delete`), and appends `session|workspace-uuid` to `~/.cmuxterm/remote-sessions.map` for the title sync in §7. Parse the workspace UUID out of `cmux workspace list --id-format both` **by regex, never by column** (see Gotchas). First run shows a one-time trust prompt.

## 6. SSH config for an always-on remote

```
Host remotehost
    HostName 100.x.y.z            # tailnet IPv4, not MagicDNS (see below)
    HostKeyAlias remotehost.tailnet-name.ts.net
    User you
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
    AddressFamily inet
    ServerAliveInterval 20
    ServerAliveCountMax 3
    TCPKeepAlive yes
    ConnectTimeout 10
```

- **Pin the tailnet IPv4.** A MagicDNS name depends on DNS resolution, which some ISP gateways interfere with, and it may resolve IPv6-only. The `100.x` address is stable for the life of the tailnet node. Keep `HostKeyAlias` pointed at the DNS name so the host key stays bound to a stable identity. Before switching, check that `ssh-keygen -F <ip>` and `ssh-keygen -F <name>` return the same key, and there is no prompt.
- **No `ControlMaster`.** It is tempting, but multiplexing puts every cmux workspace on a single TCP connection, so one blip drops all your agent sessions at once. Separate connections fail independently. cmux already multiplexes internally for scp and uploads.
- Keepalives set here override the ones cmux injects.
- On a macOS remote, put `export PATH=/opt/homebrew/bin:$PATH` in `~/.zshenv`, or non-interactive SSH won't find `tmux`.

## 7. Live workspace titles from remote agents

Claude Code (and most agent CLIs) broadcast a live conversation summary as the terminal title. tmux on the remote captures it per pane (`pane_title`) once you enable, in the remote `~/.tmux.conf`:

```tmux
set -g set-titles on
set -g set-titles-string "#{pane_title}"
set -g allow-passthrough on
```

cmux's `processTitle` follows that on its own. But `--name` pins `customTitle` with `source: user`, which overrides it. So either drop `--name` and take the live title (which falls back to a bare path when the agent goes idle), or keep `--name` and run a small poller on the laptop that rewrites the workspace title every 45s (launchd `StartInterval`):

1. Exit fast if cmux isn't running (`cmux ping`).
2. One ssh call: `tmux list-panes -a -F "#{session_name}|#{pane_title}"`.
3. For each line in `~/.cmuxterm/remote-sessions.map`, `cmux workspace rename <uuid> --title <pane_title>` when the title changed. Skip junk titles (`~`, hostnames, bare paths); prune map entries whose workspace is gone.

The poller wins over the raw `processTitle` because it holds the last good summary while the agent is idle instead of reverting to a path. Sessions start as `rs-<timestamp>` and rename themselves to the agent's live summary within a minute of real work.

## Gotchas (all learned the hard way)

- **Workspace refs are not stable, and the list output lies about columns.** `cmux workspace list --id-format both` prefixes the *selected* row with `*`, which shifts every field and will silently hand you a `workspace:N` ref where you expected a UUID. Extract the UUID by regex. Persist UUIDs, never refs: refs are reassigned on every relaunch.
- **`RemoteCommand` as an ssh-option fails** with `Cannot execute command-line and remote command`, because cmux passes its own daemon-bootstrap command line. Use `SetEnv`.
- **`cmux ssh ... -- <cmd>` needs `--ssh-option RequestTTY=force`**, or tmux dies with `open terminal failed: not a terminal`. Keep it per-invocation; putting `RequestTTY force` in `ssh_config` corrupts the output of scripted ssh calls.
- **Only `LC_*` env vars survive** macOS sshd's default `AcceptEnv LANG LC_*`. A custom prefix is dropped without an error.
- **tmux 3.7b rejects `send-keys -t '=name'`** with `can't find pane`. Use `-t 'name:'`.
- **Remote tmux mirror close semantics** (`cmux ssh-tmux`, beta): closing a mirrored tab/pane kills the real remote tmux pane (closing the app or window detaches safely). One mis-click can execute a running agent. Mirrors also are not restored on relaunch; rerun the command.
- **Mirror materialization bug** (as of 0.64.17): `remote.tmux.attach` sometimes attaches the control client without ever creating a workspace. Intermittent.
- **Auto-naming renames the actual remote tmux session** through a mirror, breaking any script that targets sessions by name.
- **Workspace-group RPC**: `workspace.group.delete` closes the group's *anchor* workspace; if the anchor is a live remote session, it dies with it. `group.create` ignores workspace params and grabs the selected workspace. Create groups via the UI (`Cmd+Shift+G`) only, and only ever member-add over RPC.
- **`scrollback-limit` unit mismatch**: bytes in Ghostty, lines in cmux, same config key.
- **Mouse-mode leakage**: a TUI that exits without disabling xterm mouse reporting leaves the shell spewing `35;39;20M`-style coordinates. Fix with `reset`, or `printf '\033[?1000l\033[?1002l\033[?1003l\033[?1006l\033[?1015l'; stty sane`. The native mirror re-seeds mouse-tracking state on reconnect; plain ssh does not.
- **CLI relay**: once any `cmux ssh` workspace has bootstrapped the remote daemon, processes on the remote can call the local cmux app via `~/.cmux/bin/cmux` (verify with `cmux ping`). Useful primitive for remote hooks and notifications.
