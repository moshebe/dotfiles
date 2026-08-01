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

# 3. Torq skills (from ~/.dotfiles/torq submodule)
DOTFILES_TORQ="$HOME/.dotfiles/torq"
if [ -d "$DOTFILES_TORQ/opencode/skills" ]; then
  for skill_dir in "$DOTFILES_TORQ/opencode/skills"/*/; do
    name=$(basename "$skill_dir")
    ln -sfn "$skill_dir" "$OPENCODE_DIR/skills/$name"
    echo "  skill:$name (torq) -> $OPENCODE_DIR/skills/$name"
  done
fi

# 4. Wire work ai-dev-tools skills (if repo is present)
# Set AI_DEV_TOOLS env var to override, or place repo at default path
AI_DEV_TOOLS="${AI_DEV_TOOLS:-$HOME/dev/torqio/ai-dev-tools}"
if [ -d "$AI_DEV_TOOLS" ]; then
  echo "  Linking work ai-dev-tools skills from $AI_DEV_TOOLS..."
  bash "$AI_DEV_TOOLS/install.sh" 2>/dev/null || true
fi

echo ""
echo "Done. OpenCode config:"
echo "  opencode  -> personal + Torq skills"
echo "  Restart OpenCode to pick up changes."
