#!/bin/zsh
# sync-skills.sh
# Sync personal skills from Claude Code to other agentic harnesses via symlink.
#
# Codex auto-imports Claude Code plugin marketplaces on launch and clones them
# into ~/.codex/plugins/cache/. So for Codex, we only sync personal skills
# (~/.claude/skills/) into ~/.agents/skills/ (canonical) and skip plugin-cache
# entirely to avoid duplicates. ~/.codex/skills/ is deprecated upstream; we
# remove our old symlinks there so Codex stops loading the same skill twice.
#
# Gemini and OpenCode have no native plugin marketplace systems, so they get
# the full personal + plugin-cache sync.

set -eo pipefail

CLAUDE_SKILLS="$HOME/.claude/skills"
PLUGIN_CACHE="$HOME/.claude/plugins/cache"
DRY_RUN=${1:-""}

CODEX_TARGET="$HOME/.agents/skills"
CODEX_DEPRECATED="$HOME/.codex/skills"

FULL_SYNC_TARGETS=(
  "$HOME/.gemini/skills"
  "$HOME/.config/opencode/skills"
)

personal_tmp=$(mktemp)
plugin_tmp=$(mktemp)
trap "rm -f $personal_tmp $plugin_tmp" EXIT

# Personal skills (~/.claude/skills/). Symlinked dirs allowed since some
# personal skills wrap npm or external installs.
for dir in "$CLAUDE_SKILLS"/*(N-/); do
  [[ -f "$dir/SKILL.md" ]] || continue
  name=$(basename "$dir")
  real_path=$(cd "$dir" && pwd -P)
  printf '%s\t%s\n' "$name" "$real_path" >> "$personal_tmp"
done

# Plugin-cache skills (for Gemini/OpenCode full sync only).
find "$PLUGIN_CACHE" -name "SKILL.md" -type f 2>/dev/null | while read skillmd; do
  [[ "$skillmd" == */template/* ]] && continue
  dir=$(dirname "$skillmd")
  name=$(basename "$dir")
  real_path=$(cd "$dir" && pwd -P)
  printf '%s\t%s\n' "$name" "$real_path" >> "$plugin_tmp"
done

personal_list=$(awk -F'\t' 'NF>=2 && !seen[$1]++' "$personal_tmp" | sort -t$'\t' -k1,1)
full_list=$(cat "$personal_tmp" "$plugin_tmp" | awk -F'\t' 'NF>=2 && !seen[$1]++' | sort -t$'\t' -k1,1)

personal_count=$(wc -l < "$personal_tmp" | tr -d ' ')
full_count=$(printf '%s\n' "$full_list" | grep -c '^' || true)

if [[ "$DRY_RUN" == "--dry-run" ]]; then
  echo "=== Codex (personal only) -> $CODEX_TARGET ==="
  echo "$personal_count personal skills to sync"
  printf '%s\n' "$personal_list" | while IFS=$'\t' read name source; do
    [[ -z "$name" ]] && continue
    short=$(echo "$source" | sed "s|$HOME|~|")
    echo "  $name  <- $short"
  done
  echo
  echo "=== Codex deprecated cleanup -> $CODEX_DEPRECATED ==="
  if [[ -d "$CODEX_DEPRECATED" ]]; then
    removed_preview=0
    for link in "$CODEX_DEPRECATED"/*(N@); do
      removed_preview=$((removed_preview + 1))
    done
    echo "Would remove $removed_preview stale symlinks (deprecated path)"
  fi
  echo
  echo "=== Gemini/OpenCode (full sync) ==="
  echo "$full_count skills to sync to each"
  exit 0
fi

# Sync personal skills into a target dir. Replaces stale non-symlink copies
# (the frozen first-run translation entries Codex wrote into ~/.agents/skills/).
sync_personal_into() {
  local target=$1
  mkdir -p "$target"
  local target_name=$(echo "$target" | sed "s|$HOME/||")
  printf '%s\n' "$personal_list" | while IFS=$'\t' read name source; do
    [[ -z "$name" ]] && continue
    link="$target/$name"

    # Replace stale non-symlink directory (frozen import copy) with a live symlink.
    if [[ -e "$link" && ! -L "$link" ]]; then
      rm -rf "$link"
    fi

    if [[ -L "$link" ]]; then
      current=$(readlink "$link")
      [[ "$current" == "$source" ]] && continue
      rm "$link"
    fi

    ln -s "$source" "$link"
  done
  echo "  $target_name: $personal_count personal skills synced"
}

# Full sync (personal + plugin-cache). Preserves harness-native skills that
# already exist as real directories at the target.
sync_full_into() {
  local target=$1
  mkdir -p "$target"
  local target_name=$(echo "$target" | sed "s|$HOME/||")
  printf '%s\n' "$full_list" | while IFS=$'\t' read name source; do
    [[ -z "$name" ]] && continue
    link="$target/$name"

    if [[ -e "$link" && ! -L "$link" ]]; then
      continue
    fi

    if [[ -L "$link" ]]; then
      current=$(readlink "$link")
      [[ "$current" == "$source" ]] && continue
      rm "$link"
    fi

    ln -s "$source" "$link"
  done
  echo "  $target_name: $full_count skills synced"
}

echo "Syncing personal skills to Codex..."
sync_personal_into "$CODEX_TARGET"

# Remove our old symlinks from ~/.codex/skills/. Codex still reads from there
# for backwards compatibility, which causes duplicates with ~/.agents/skills/.
# Empty stub dirs and non-symlink content are left alone.
if [[ -d "$CODEX_DEPRECATED" ]]; then
  removed=0
  for link in "$CODEX_DEPRECATED"/*(N@); do
    rm "$link"
    removed=$((removed + 1))
  done
  echo "  .codex/skills: removed $removed stale symlinks (deprecated path)"
fi

echo "Syncing personal + plugin skills to Gemini/OpenCode..."
for target in "${FULL_SYNC_TARGETS[@]}"; do
  sync_full_into "$target"
done

echo "Done."
