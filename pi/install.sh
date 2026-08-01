#!/usr/bin/env bash
# pi/install.sh — wire ~/.dotfiles/pi skills into ~/.pi and ~/.claude/agents
#
# Run once after cloning dotfiles on a new machine, or via `make skills`.
# Safe to re-run: uses -f/-n on symlinks to overwrite stale links.
#
# What this does:
#   1. Symlinks global AGENTS.md (default profile)
#   2. Symlinks skills into ~/.pi/agent/skills/
#   3. Symlinks skills into ~/.claude/agents/ (Claude Code subagents)

set -euo pipefail

DOTFILES_PI="$HOME/.dotfiles/pi"
PI_AGENT="$HOME/.pi/agent"

echo "Setting up pi config..."

# 1. Global AGENTS.md (default profile)
if [ -f "$DOTFILES_PI/AGENTS.md" ]; then
  ln -sf "$DOTFILES_PI/AGENTS.md" "$PI_AGENT/AGENTS.md"
  echo "  ✓ AGENTS.md → $PI_AGENT/AGENTS.md"
fi

# 2. Skills — each skill is a directory containing SKILL.md
mkdir -p "$PI_AGENT/skills"
for skill_dir in "$DOTFILES_PI/skills"/*/; do
  name=$(basename "$skill_dir")
  ln -sfn "$skill_dir" "$PI_AGENT/skills/$name"
  echo "  ✓ skill:$name → $PI_AGENT/skills/$name"
done

# 3. Claude Code agents — skills work as subagents in Claude Code
CLAUDE_AGENTS="$HOME/.claude/agents"
mkdir -p "$CLAUDE_AGENTS"
for skill_dir in "$DOTFILES_PI/skills"/*/; do
  name=$(basename "$skill_dir")
  ln -sfn "$skill_dir" "$CLAUDE_AGENTS/$name"
  echo "  ✓ claude:$name → $CLAUDE_AGENTS/$name"
done

echo ""
echo "Done."
echo "  pi    → personal work (skills available)"
echo "  claude → skills available as subagents in ~/.claude/agents/"
