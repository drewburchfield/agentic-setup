# Multi-Account Claude + cmux Auto-Resume

Run **several Claude Code logins at once**, each in its own cmux tab, and have [cmux](https://cmux.com) bring each tab back under the **same login** after quit/reopen.

This is **not** account switching. You do not flip one session between logins. Each tab is bound to one account for its whole life; resume reattaches that binding.

Complementary to [cmux-remote-agents.md](cmux-remote-agents.md) (harness hooks and remote tmux). This doc is only about **account identity** across resume.

Scripts: [`scripts/claude-multi-account/`](../scripts/claude-multi-account/).

**Documentation scope (this public repo):** keep the mechanism exact (config dirs, dispatch, hooks, resume behavior). Use generic seat names (`account-1`, `account-2`, …) and **main vs additional** only. Do not put org- or person-specific profile labels here, and do not frame the pattern as personal-vs-work or as switching one session between logins. Machine-local operator notes may use real launcher names.

## Vocabulary

| Term | Meaning |
|------|---------|
| **Main account** | Default Claude Code install: bare `claude`, config dir `~/.claude` |
| **Additional account** | A second (third, …) login under `~/.claude-profiles/<name>` |
| **Profile launcher** | Command that starts Claude under one additional account, e.g. `account-1-claude` |
| **Sticky identity** | A tab always resumes under the account it was started with |

Example additional names in this doc: `account-1`, `account-2`. Use any names you like.

## The problem

Claude Code selects credentials and transcript storage with `CLAUDE_CONFIG_DIR` (default `~/.claude` for the main account).

cmux auto-resume rebuilds something like:

```text
claude --resume <session-id> [--permission-mode auto]
```

It does **not** re-run a custom launcher name, and on many builds the restore record’s `environment` is empty. So a tab started under an **additional** account often relaunches under the **main** account’s config dir: same conversation id when history is shared, wrong login/subscription.

Sleep or lid-close does not hit this path (the process keeps running). Full quit, reboot, or agent hibernation does.

## Two tools, different jobs

| Tool | Job | Resume story |
|------|-----|----------------|
| **Profile launchers** (`claude-profile` / `account-1-claude`) | Parallel seats: each additional account has its own `CLAUDE_CONFIG_DIR`; optional shared skills/settings from the main install | With the dispatch layer below, cmux resume keeps that seat’s account |
| **[claude-swap](https://pypi.org/project/claude-swap/)** (optional, not this recipe) | Global rotate/switch of a “current” account | Different product model. Not how these cmux tabs stay sticky |

This repo’s recipe is **parallel sticky seats** (profile launcher + cmux dispatch). It does not implement global account switching.

## Architecture

```text
  account-1-claude / account-2-claude   (thin profile launchers)
       |
       |  export CLAUDE_CONFIG_DIR=~/.claude-profiles/<name>
       v
  cmux per-surface claude shim          (hooks, --session-id, --settings)
       |
       v
  cmux-claude-wrapper (bundled)         (finds "real" claude via settings)
       |
       v
  cmux-claude-profile-dispatch          (automation.claudeBinaryPath)
       |  on --session-id: record map[session]=configDir
       |  on --resume:     lookup map, re-export CLAUDE_CONFIG_DIR
       v
  real Claude binary                    (~/.local/share/claude/versions/...)
```

**Session map:** `~/.cmuxterm/claude-config-dir-by-session.json`

```json
{
  "c797e9df-…": {
    "configDir": "/Users/you/.claude-profiles/account-1",
    "profile": "account-1",
    "updatedAt": "2026-08-09T21:19:00Z",
    "source": "hook"
  }
}
```

**Record paths:**

1. Dispatch sees `CLAUDE_CONFIG_DIR` under `~/.claude-profiles/` plus `--session-id` / `--resume`.
2. Claude `SessionStart` / `Stop` hook runs `cmux-claude-profile-record` (always exit 0).

**Lookup on resume:** map hit first; else a single profile-local marker under `session-env/` or `security/` (never scan shared `projects/` symlinks, or every main-account session would look like every additional profile).

## Quick install (new machine)

```bash
# From a clone of this repo
cd scripts/claude-multi-account
./install.sh account-1 account-2          # names are yours; any number

# Or install tools only, then symlink by hand:
./install.sh
ln -s ~/.local/bin/claude-profile ~/.local/bin/account-1-claude
```

What `install.sh` does:

1. Copies `cmux-claude-profile-dispatch`, `cmux-claude-profile-record`, and `claude-profile` to `~/.local/bin`.
2. Adds the record command to `~/.claude/settings.json` hooks (`SessionStart`, `Stop`).
3. Sets `automation.claudeBinaryPath` in `~/.config/cmux/cmux.json` to the dispatch script.
4. Runs `cmux reload-config` when cmux is available.
5. Creates `~/.claude-profiles/<name>/` and `<name>-claude` symlinks for any names you pass.

First launch of each **additional** account still prompts OAuth for that login only. The **main** account (`claude` / `~/.claude`) is unchanged.

### Optional: cmux launch actions

```jsonc
// ~/.config/cmux/cmux.json
{
  "actions": {
    "account-1-claude-new": {
      "type": "command",
      "title": "New Account 1 Claude",
      "subtitle": "Claude Code on additional account 1",
      "command": "account-1-claude --share-history",
      "target": "newTabInCurrentPane",
      "keywords": ["claude", "profile", "account"],
      "icon": { "type": "symbol", "name": "person.crop.circle" }
    }
  }
}
```

### Optional: sidebar colors

```zsh
# ~/.zshrc — extend the harness color wrappers from cmux-remote-agents.md
account-1-claude() { _cmux_ws_color Amber;  command account-1-claude "$@"; }
account-2-claude() { _cmux_ws_color Indigo; command account-2-claude "$@"; }
```

## Day-to-day usage

```bash
# Additional account 1 (new profiles start isolated; history mode is sticky,
# so a bare launch keeps whatever mode the profile already has)
account-1-claude

# Share projects/ + history.jsonl with the main account's ~/.claude (symlink only)
account-1-claude --share-history

# Pass through any Claude flags
account-1-claude --share-history --permission-mode auto --remote-control

# From cmux CLI
cmux new-workspace --name "account-1 task" --cwd ~/code/app \
  --command "account-1-claude --share-history --permission-mode auto"
```

| Flag / behavior | Survives cmux auto-resume? |
|-----------------|----------------------------|
| Account / `CLAUDE_CONFIG_DIR` | Yes (via dispatch + map) |
| `--permission-mode …` | Yes (cmux native sanitizer) |
| `--share-history` | Sticky on disk once applied (symlinks), not re-parsed as a flag |
| Arbitrary one-off Claude flags | Only what cmux’s sanitizer keeps (model/sandbox/config/cwd class) |

Bare `claude` is always the **main** seat. Profile launchers only affect tabs you start with them. Several main and additional tabs can run **at the same time**.

**`--share-history`:** optional shared **transcript library** with the main config dir. It is not shared identity. Each process still runs under one account; do not treat a conversation as portable across logins.

## Why the launcher must hit the cmux shim

Profile scripts that `exec ~/.local/bin/claude` directly skip cmux’s per-surface shim, so:

- cmux hooks often never inject `--settings` / session tracking
- `automation.claudeBinaryPath` never runs
- resume cannot re-pin the additional account

Inside cmux, the launcher prefers, in order:

1. `$CMUX_CLAUDE_WRAPPER_SHIM`
2. `$TMPDIR/cmux-cli-shims/$CMUX_SURFACE_ID/claude`
3. `/Applications/cmux.app/Contents/Resources/bin/cmux-claude-wrapper`

Outside cmux it still uses `~/.local/bin/claude` (or `PATH`).

## Files and settings (checklist)

| Path | Role |
|------|------|
| `~/.local/bin/claude-profile` | Generic launcher |
| `~/.local/bin/<name>-claude` | Symlink → `claude-profile` (additional account) |
| `~/.local/bin/cmux-claude-profile-dispatch` | `automation.claudeBinaryPath` target |
| `~/.local/bin/cmux-claude-profile-record` | SessionStart/Stop hook |
| `~/.claude` | Main account config + auth |
| `~/.claude-profiles/<name>/` | Additional account config + auth |
| `~/.cmuxterm/claude-config-dir-by-session.json` | session id → config dir |
| `~/.claude/settings.json` → hooks | Records additional-account sessions |
| `~/.config/cmux/cmux.json` → `automation.claudeBinaryPath` | Wires dispatch into every cmux Claude launch |

Shared (symlinked) by default from the **main** `~/.claude`: `settings.json`, skills, commands, agents, `mcp.json`, etc. History (`projects/`, `history.jsonl`) is opt-in via `--share-history`.

**Status/setup must not flip history links.** `claude-profile <name> --status` uses a `keep` mode so inspection never unlinks an existing share-history setup.

## Smoke tests (no full app quit required)

```bash
# 1. Dispatch finds the real binary and passes through
cmux-claude-profile-dispatch --version

# 2. Fake "real" binary: additional-account session must re-set CLAUDE_CONFIG_DIR
FAKE=$(mktemp)
printf '%s\n' '#!/bin/bash' 'echo CONFIG=${CLAUDE_CONFIG_DIR:-<unset>}' >"$FAKE"
chmod +x "$FAKE"

# After you have run account-1-claude at least once, pick a session id from the map:
python3 -c 'import json;from pathlib import Path;print(json.dumps(json.load(open(Path.home()/".cmuxterm"/"claude-config-dir-by-session.json")), indent=2)[:800])'

env -u CLAUDE_CONFIG_DIR CMUX_CLAUDE_REAL_BIN="$FAKE" \
  cmux-claude-profile-dispatch --resume <account-1-session-uuid>
# expect: CONFIG=/Users/you/.claude-profiles/account-1

env -u CLAUDE_CONFIG_DIR CMUX_CLAUDE_REAL_BIN="$FAKE" \
  cmux-claude-profile-dispatch --resume <main-or-unknown-uuid>
# expect: CONFIG=<unset>

rm -f "$FAKE"

# 3. Launcher status (inside a cmux terminal, Claude bin should be the surface shim)
account-1-claude --status
```

### Full quit/reopen (manual)

1. Start `account-1-claude --share-history` in a cmux workspace; send one message.
2. Confirm the session id appears in the map.
3. Quit cmux fully (Cmd-Q), reopen.
4. Tab should auto-resume; process env should show `CLAUDE_CONFIG_DIR=…/account-1` (`ps eww -p <pid>`).

## Backfilling an existing machine

If additional-account sessions already exist before install:

```bash
python3 <<'PY'
import json, os
from datetime import datetime, timezone
from pathlib import Path

map_path = Path.home() / ".cmuxterm" / "claude-config-dir-by-session.json"
root = Path.home() / ".claude-profiles"
data = {}
if map_path.exists():
    try:
        data = json.loads(map_path.read_text())
    except Exception:
        data = {}
now = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
for profile in root.iterdir() if root.is_dir() else []:
    if not profile.is_dir():
        continue
    se = profile / "session-env"
    if se.is_dir():
        for child in se.iterdir():
            data[child.name] = {
                "configDir": str(profile.resolve()),
                "profile": profile.name,
                "updatedAt": now,
                "source": "backfill-session-env",
            }
map_path.parent.mkdir(parents=True, exist_ok=True)
map_path.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n")
os.chmod(map_path, 0o600)
print(f"entries: {len(data)}")
PY
```

## Gotchas

- **Parallel seats, not a toggle.** Starting `account-1-claude` does not change what bare `claude` is. Closing one tab does not migrate its conversation to another account.
- **Do not point `automation.claudeBinaryPath` at a path that re-enters the cmux shim forever.** Dispatch resolves the real binary via `~/.local/bin/claude` → `~/.local/share/claude/versions/…` and refuses to exec itself.
- **`--share-history` makes `projects/` a symlink into the main `~/.claude`.** Resume can still find transcripts under the main tree; account correctness still depends on `CLAUDE_CONFIG_DIR`, which is why the map exists.
- **cmux’s own `reconcile_claude_config_dir_for_resume` only searches `~/.claude` and a few subrouter/codex-account roots**, not `~/.claude-profiles/*`. Dispatch runs *after* that and overrides from the map when needed.
- **Editing launchers or settings does not interrupt live agents.** New behavior applies on the next launch/resume path.
- **Custom `cmux surface resume set --shell …` needs Resume Commands approval** for non-agent surfaces. This design stays on the native Claude agent resume path so you avoid that prompt.
- **Public / multi-machine:** keep org- or client-specific profile *names* out of shared scripts; pass them to `install.sh` or create local symlinks only.

## Portable form

```text
main:       claude                  →  ~/.claude
additional: claude-profile <name>
         or <name>-claude           →  ~/.claude-profiles/<name>
+ cmux-claude-profile-dispatch as automation.claudeBinaryPath
+ SessionStart record hook
```

Replicate with `scripts/claude-multi-account/install.sh` and this document.
