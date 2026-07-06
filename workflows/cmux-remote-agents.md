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

cmux reads your existing Ghostty config (`~/.config/ghostty/config`) for fonts/theme/opacity. It loads the **first** config file it finds and stops, unlike Ghostty which merges both locations. cmux-only keys (`sidebar-font-size`, `surface-tab-bar-font-size`) can live in the same file; Ghostty flags them as unknown but ignores them.

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
# ~/.zshrc — no-op outside cmux
_cmux_ws_color() { [ -n "$CMUX_SURFACE_ID" ] && command cmux workspace-action --action set-color --color "$1" >/dev/null 2>&1; }
claude() { _cmux_ws_color Orange;  command claude "$@"; }
codex()  { _cmux_ws_color Teal;    command codex "$@"; }
grok()   { _cmux_ws_color Crimson; command grok "$@"; }
agy()    { _cmux_ws_color Aqua;    command agy "$@"; }
```

Colors are workspace-level only; horizontal surface tabs can only be renamed.

## 4. One-click persistent remote sessions (group + button)

Goal: a workspace group named after the remote host whose **+ button** creates a persistent tmux session on that host, attached in a new grouped workspace. Sessions survive laptop sleep, cmux quitting, and network drops; only killing tmux on the host ends them.

### Why plain `ssh + tmux attach` instead of cmux's native mirror

cmux has a Remote tmux beta (`cmux ssh-tmux host`) that mirrors tmux into native workspaces with live titles. It's tempting but has sharper semantics (see Gotchas). The plain-attach pattern below trades built-in live titles (recoverable, see §5) for a setup where no sidebar click can kill a running agent.

### Helper script

`~/.local/bin/cmux-remote-shell` runs *inside* the new workspace surface:

```zsh
#!/bin/zsh
# Ensures a tmux session exists on the remote host, then execs into it.
name="${1:-rs-$(date +%m%d-%H%M%S)}"
ssh remotehost "tmux has-session -t '=$name' 2>/dev/null || tmux new-session -d -s '$name' -c ~/dev"
if [ -n "${CMUX_WORKSPACE_ID:-}" ]; then
  cmux workspace rename "$CMUX_WORKSPACE_ID" --title "$name" >/dev/null 2>&1 || true
  grep -qF "$name|$CMUX_WORKSPACE_ID" ~/.cmuxterm/remote-sessions.map 2>/dev/null \
    || echo "$name|$CMUX_WORKSPACE_ID" >> ~/.cmuxterm/remote-sessions.map   # for title sync (§5)
fi
exec ssh -t remotehost "tmux attach -t '=$name'"
```

### cmux.json wiring

The `actions` registry + `workspaceGroups.byCwd.*.contextMenu` puts the action on every group's + button (right-click) and in the Command Palette. Documented as nightly-only, but works on stable 0.64.17.

```jsonc
{
  "actions": {
    "remote-new": {
      "type": "workspaceCommand",
      "title": "New Remote Session",
      "commandName": "Remote Session",
      "icon": { "type": "symbol", "name": "server.rack" }
    }
  },
  "commands": [
    {
      "name": "Remote Session",
      "workspace": {
        "name": "remote",
        "layout": { "pane": { "surfaces": [
          { "type": "terminal", "name": "remote", "command": "cmux-remote-shell" }
        ] } }
      }
    }
  ],
  "workspaceGroups": {
    "byCwd": { "*": { "contextMenu": [ { "action": "remote-new", "title": "New Remote Session" } ] } }
  }
}
```

Workspaces created from a group's + button land in that group automatically. First run shows a one-time trust prompt.

## 5. Live workspace titles from remote agents

Claude Code (and most agent CLIs) broadcast a live conversation summary as the terminal title. tmux on the remote host captures it per pane (`pane_title`) once you enable, in the remote `~/.tmux.conf`:

```tmux
set -g set-titles on
set -g set-titles-string "#{pane_title}"
set -g allow-passthrough on
```

A small poller on the laptop copies those titles onto the mapped workspaces every 45s (launchd `StartInterval`), giving mirror-style live titles with none of the mirror's risk:

1. Exit fast if cmux isn't running (`cmux ping`).
2. One ssh call: `tmux list-panes -a -F "#{session_name}|#{pane_title}"`.
3. For each line in `~/.cmuxterm/remote-sessions.map`, rename the workspace via `cmux workspace rename <uuid> --title <pane_title>` when the title changed. Skip junk titles (`~`, hostnames, bare paths); prune map entries whose workspace is gone.

Result: + button sessions start as `rs-<timestamp>` and rename themselves to the agent's live summary within a minute of real work.

## Gotchas (all learned the hard way)

- **Remote tmux mirror close semantics**: closing a mirrored tab/pane kills the real remote tmux pane (app/window close detaches safely). One mis-click can execute a running agent.
- **Mirror materialization bug** (as of 0.64.17): `remote.tmux.attach` sometimes attaches the control client without ever creating a workspace. Intermittent.
- **Workspace-group RPC**: `workspace.group.delete` closes the group's *anchor* workspace; if the anchor is a live mirror, the remote session dies with it. `group.create` ignores workspace params and grabs the selected workspace. Create groups via the UI (`Cmd+Shift+G`) only.
- **Auto-naming renames the actual remote tmux session** through a mirror, breaking any script that targets sessions by name. Target tmux session IDs, not names.
- **`scrollback-limit` unit mismatch**: bytes in Ghostty, lines in cmux, same config key.
- **Mirrors aren't restored on relaunch** (rerun `cmux ssh-tmux`); plain-attach workspaces restore themselves because session restore re-runs the attach command.
- **Non-interactive SSH PATH**: cmux invokes remote tmux over non-interactive SSH; on a macOS remote, put `export PATH=/opt/homebrew/bin:$PATH` in `~/.zshenv` or the version check fails with "no tmux".
- **CLI relay**: once any `cmux ssh` workspace has bootstrapped the remote daemon, processes on the remote can call the local cmux app via `~/.cmux/bin/cmux` (verified with `cmux ping`). Useful primitive for remote hooks/notifications.
