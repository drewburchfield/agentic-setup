#!/usr/bin/env bash
# Install multi-account Claude profile launchers + cmux resume dispatch.
#
# Usage:
#   ./install.sh                        # install dispatch, record hook, generic launcher
#   ./install.sh account-1 account-2    # also create account-1-claude, account-2-claude
#
# Idempotent. Backs up ~/.claude/settings.json and ~/.config/cmux/cmux.json before
# editing. Does not log you in; first profile launch still prompts OAuth.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
BIN="${CLAUDE_MULTI_ACCOUNT_BIN:-$HOME/.local/bin}"
MAP_DIR="${CMUX_CLAUDE_PROFILE_MAP_DIR:-$HOME/.cmuxterm}"
PROFILES_ROOT="${CLAUDE_PROFILES_ROOT:-$HOME/.claude-profiles}"

DISPATCH_SRC="$ROOT/cmux-claude-profile-dispatch"
RECORD_SRC="$ROOT/cmux-claude-profile-record"
LAUNCHER_SRC="$ROOT/claude-profile"

DISPATCH_DST="$BIN/cmux-claude-profile-dispatch"
RECORD_DST="$BIN/cmux-claude-profile-record"
LAUNCHER_DST="$BIN/claude-profile"

timestamp() { date +%Y%m%d%H%M%S; }

backup_file() {
  local f="$1"
  [[ -f "$f" ]] || return 0
  local bak="${f}.bak.$(timestamp)"
  cp -p "$f" "$bak"
  echo "backed up $f -> $bak"
}

install_script() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  chmod +x "$dst"
  echo "installed $dst"
}

ensure_settings_hook() {
  local settings="$HOME/.claude/settings.json"
  mkdir -p "$(dirname "$settings")"
  if [[ ! -f "$settings" ]]; then
    printf '%s\n' '{}' >"$settings"
  fi
  backup_file "$settings"
  python3 - "$settings" "$RECORD_DST" <<'PY'
import json, sys
from pathlib import Path

path, record = Path(sys.argv[1]), sys.argv[2]
data = json.loads(path.read_text() or "{}")
hooks = data.setdefault("hooks", {})

def ensure(event: str) -> None:
    entries = hooks.get(event) or []
    if not isinstance(entries, list):
        entries = []
    if "cmux-claude-profile-record" in json.dumps(entries):
        print(f"{event}: record hook already present")
        hooks[event] = entries
        return
    entries.append({
        "matcher": "",
        "hooks": [{
            "type": "command",
            "command": record,
            "timeout": 5,
            "async": True,
        }],
    })
    hooks[event] = entries
    print(f"{event}: added record hook")

ensure("SessionStart")
ensure("Stop")
data["hooks"] = hooks
path.write_text(json.dumps(data, indent=2) + "\n")
print(f"updated {path}")
PY
}

ensure_cmux_binary_path() {
  local cfg="$HOME/.config/cmux/cmux.json"
  mkdir -p "$(dirname "$cfg")"
  if [[ ! -f "$cfg" ]]; then
    cat >"$cfg" <<'EOF'
{
  "$schema": "https://raw.githubusercontent.com/manaflow-ai/cmux/main/web/data/cmux.schema.json",
  "schemaVersion": 1
}
EOF
  fi
  backup_file "$cfg"
  python3 - "$cfg" "$DISPATCH_DST" <<'PY'
import json, sys
from pathlib import Path

path, dispatch = Path(sys.argv[1]), sys.argv[2]
data = json.loads(path.read_text() or "{}")
auto = data.setdefault("automation", {})
auto["claudeBinaryPath"] = dispatch
data["automation"] = auto
path.write_text(json.dumps(data, indent=2) + "\n")
print(f"set automation.claudeBinaryPath = {dispatch}")
print(f"updated {path}")
PY
  if command -v cmux >/dev/null 2>&1; then
    cmux reload-config >/dev/null 2>&1 || true
    echo "reloaded cmux config (if cmux is running)"
  fi
}

make_profile_symlink() {
  local name="$1"
  local link="$BIN/${name}-claude"
  ln -sfn "$LAUNCHER_DST" "$link"
  echo "symlink $link -> claude-profile  (profile: $name)"
  mkdir -p "$PROFILES_ROOT/$name"
}

main() {
  for f in "$DISPATCH_SRC" "$RECORD_SRC" "$LAUNCHER_SRC"; do
    [[ -f "$f" ]] || die "missing $f"
  done

  install_script "$DISPATCH_SRC" "$DISPATCH_DST"
  install_script "$RECORD_SRC" "$RECORD_DST"
  install_script "$LAUNCHER_SRC" "$LAUNCHER_DST"

  mkdir -p "$MAP_DIR" "$PROFILES_ROOT"
  chmod 700 "$PROFILES_ROOT" 2>/dev/null || true

  ensure_settings_hook
  ensure_cmux_binary_path

  if [[ $# -gt 0 ]]; then
    local name
    for name in "$@"; do
      make_profile_symlink "$name"
    done
  else
    echo
    echo "No profile names passed. Create launchers later with:"
    echo "  ln -s $LAUNCHER_DST $BIN/<name>-claude"
    echo "  # or re-run: $0 account-1 account-2"
  fi

  cat <<EOF

Done.

Next:
  1. Main account is unchanged:  claude
  2. Additional account:         <name>-claude --share-history
     First launch prompts OAuth for that login only.
  3. Prefer launching additional accounts inside cmux so resume stays sticky.
  4. Map file: $MAP_DIR/claude-config-dir-by-session.json
  5. Optional smoke test (no TUI):
       CMUX_CLAUDE_REAL_BIN=/bin/echo \\
         $DISPATCH_DST --resume <session-id-from-an-additional-account-run>

See workflows/cmux-claude-multi-account-resume.md
EOF
}

die() { echo "install.sh: $*" >&2; exit 1; }

main "$@"
