#!/usr/bin/env bash
# opencode/install.sh — wire ~/.dotfiles/opencode into ~/.config/opencode
#
# Run once after cloning dotfiles on a new machine, or via `make opencode`.
# Safe to re-run: uses -f/-n on symlinks to overwrite stale links.
#
# What this does:
#   1. Symlinks opencode.json to ~/.config/opencode/opencode.json
#   2. Symlinks personal skills into ~/.config/opencode/skills/

set -euo pipefail

DOTFILES_OPENCODE="$HOME/.dotfiles/opencode"
OPENCODE_DIR="$HOME/.config/opencode"

echo "Setting up OpenCode config..."

# 1. Config file
mkdir -p "$OPENCODE_DIR"
ln -sf "$DOTFILES_OPENCODE/opencode.json" "$OPENCODE_DIR/opencode.json"
echo "  opencode.json -> $OPENCODE_DIR/opencode.json"

# 2. Personal skills
mkdir -p "$OPENCODE_DIR/skills"
for skill_dir in "$DOTFILES_OPENCODE/skills"/*/; do
  name=$(basename "$skill_dir")
  ln -sfn "$skill_dir" "$OPENCODE_DIR/skills/$name"
  echo "  skill:$name -> $OPENCODE_DIR/skills/$name"
done

# 3. Work overlay skills (WORK_OVERLAY_DIR set by the private work overlay)
if [ -n "${WORK_OVERLAY_DIR:-}" ] && [ -d "$WORK_OVERLAY_DIR/opencode/skills" ]; then
  for skill_dir in "$WORK_OVERLAY_DIR/opencode/skills"/*/; do
    name=$(basename "$skill_dir")
    ln -sfn "$skill_dir" "$OPENCODE_DIR/skills/$name"
    echo "  skill:$name (work) -> $OPENCODE_DIR/skills/$name"
  done
fi

# 4. Work plugin skills (AI_DEV_TOOLS set by the private work overlay)
if [ -n "${AI_DEV_TOOLS:-}" ] && [ -d "$AI_DEV_TOOLS" ]; then
  echo "  Linking work plugin skills from $AI_DEV_TOOLS..."
  bash "$AI_DEV_TOOLS/install.sh" 2>/dev/null || true
fi

echo ""
echo "Done. OpenCode config:"
echo "  opencode  -> personal + work skills"
echo "  Restart OpenCode to pick up changes."
