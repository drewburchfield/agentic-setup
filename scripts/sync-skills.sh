#!/bin/zsh
# sync-skills.sh
# Mirrors all Claude Code skills (personal + plugin) to other AI harnesses.
# Safe to re-run anytime. Only creates/updates symlinks, never touches real files.

set -eo pipefail

CLAUDE_SKILLS="$HOME/.claude/skills"
PLUGIN_CACHE="$HOME/.claude/plugins/cache"
DRY_RUN=${1:-""}

TARGETS=(
  "$HOME/.gemini/skills"
  "$HOME/.codex/skills"
  "$HOME/.config/opencode/skills"
)

# Collect unique skill directories using a temp file for dedup
tmpfile=$(mktemp)
trap "rm -f $tmpfile" EXIT

# 1. Personal skills first (these take priority). Include symlinked
# directories because some personal skills wrap npm or compatibility installs.
for dir in "$CLAUDE_SKILLS"/*(N-/); do
  [[ -f "$dir/SKILL.md" ]] || continue
  name=$(basename "$dir")
  real_path=$(cd "$dir" && pwd -P)
  printf '%s\t%s\n' "$name" "$real_path" >> "$tmpfile"
done

# 2. Plugin skills
find "$PLUGIN_CACHE" -name "SKILL.md" -type f 2>/dev/null | while read skillmd; do
  [[ "$skillmd" == */template/* ]] && continue
  dir=$(dirname "$skillmd")
  name=$(basename "$dir")
  real_path=$(cd "$dir" && pwd -P)
  printf '%s\t%s\n' "$name" "$real_path" >> "$tmpfile"
done

# Deduplicate: keep first occurrence per name (personal skills win since they're listed first)
deduped=$(awk -F'\t' '!seen[$1]++' "$tmpfile" | sort -t'	' -k1,1)
count=$(echo "$deduped" | wc -l | tr -d ' ')

if [[ "$DRY_RUN" == "--dry-run" ]]; then
  echo "=== $count unique skills ==="
  echo "$deduped" | while IFS=$'\t' read name source; do
    short=$(echo "$source" | sed "s|$HOME|~|")
    echo "  $name  <- $short"
  done
  exit 0
fi

echo "Syncing $count skills to ${#TARGETS[@]} harnesses..."

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  target_name=$(echo "$target" | sed "s|$HOME/||")
  added=0
  updated=0
  skipped=0

  echo "$deduped" | while IFS=$'\t' read name source; do
    link="$target/$name"

    # Skip if a real (non-symlink) directory exists (native skill for that harness)
    if [[ -e "$link" && ! -L "$link" ]]; then
      skipped=$((skipped + 1))
      continue
    fi

    # Skip if symlink already points to the right place
    if [[ -L "$link" ]]; then
      current=$(readlink "$link")
      if [[ "$current" == "$source" ]]; then
        continue
      fi
      rm "$link"
      updated=$((updated + 1))
    else
      added=$((added + 1))
    fi

    ln -s "$source" "$link"
  done

  echo "  $target_name: synced"
done

echo "Done. $count skills available in Gemini, Codex, and OpenCode."
