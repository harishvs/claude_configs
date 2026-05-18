#!/usr/bin/env bash
# Symlink files in this repo into ~/.claude/. Existing files are backed up.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
TS="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$CLAUDE_DIR/output-styles" "$CLAUDE_DIR/skills"

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    mv "$dst" "$dst.bak.$TS"
    echo "backed up existing $dst -> $dst.bak.$TS"
  fi
  ln -s "$src" "$dst"
  echo "linked $dst -> $src"
}

link "$REPO_DIR/CLAUDE.md"                              "$CLAUDE_DIR/CLAUDE.md"
link "$REPO_DIR/output-styles/autonomous-programmer.md" "$CLAUDE_DIR/output-styles/autonomous-programmer.md"
link "$REPO_DIR/output-styles/pair-programmer.md"       "$CLAUDE_DIR/output-styles/pair-programmer.md"

for skill_dir in "$REPO_DIR"/skills/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name="$(basename "$skill_dir")"
  link "${skill_dir%/}" "$CLAUDE_DIR/skills/$skill_name"
done

echo "done."
