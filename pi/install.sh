#!/usr/bin/env bash
# setup.sh — wire ~/.dotfiles/pi into ~/.pi and ~/.claude/agents
#
# Run this once after cloning dotfiles on a new machine.
# Safe to re-run: uses -f (force) on symlinks so it overwrites stale links.
#
# What this does:
#   1. Symlinks AGENTS.md (default profile global rules)
#   2. Symlinks extensions into ~/.pi/agent/extensions/
#   3. Symlinks skills into ~/.pi/agent/skills/
#   4. Sets up the Torq profile AGENTS.md + extensions + skills
#   5. Symlinks skills into ~/.claude/agents/ (Claude Code)

set -euo pipefail

DOTFILES_PI="$HOME/.dotfiles/pi"
DOTFILES_TORQ_PI="$HOME/.dotfiles/torq/pi"
PI_AGENT="$HOME/.pi/agent"
PI_TORQ="$HOME/.pi/torq"

echo "Setting up pi config..."

# 1. Global AGENTS.md (default profile)
ln -sf "$DOTFILES_PI/AGENTS.md" "$PI_AGENT/AGENTS.md"
echo "  ✓ AGENTS.md → $PI_AGENT/AGENTS.md"

# 2. Extensions directory
# Each extension is symlinked individually so pi can hot-reload them
mkdir -p "$PI_AGENT/extensions"
for ext in "$DOTFILES_PI/pi-extensions/"*.ts; do
  name=$(basename "$ext")
  ln -sf "$ext" "$PI_AGENT/extensions/$name"
  echo "  ✓ $name → $PI_AGENT/extensions/$name"
done

# 3. Skills — each skill is a directory containing SKILL.md
# Pi discovers skills from ~/.pi/agent/skills/<skill-name>/
# Use -n so macOS ln doesn't create the link *inside* an existing dir symlink
mkdir -p "$PI_AGENT/skills"
for skill_dir in "$DOTFILES_PI/skills"/*/; do
  name=$(basename "$skill_dir")
  ln -sfn "$skill_dir" "$PI_AGENT/skills/$name"
  echo "  ✓ skill:$name → $PI_AGENT/skills/$name"
done

# 4. Torq profile — AGENTS.md + shared skills + shared extensions
mkdir -p "$PI_TORQ"
ln -sf "$DOTFILES_TORQ_PI/AGENTS.md" "$PI_TORQ/AGENTS.md"
echo "  ✓ torq/AGENTS.md → $PI_TORQ/AGENTS.md"

mkdir -p "$PI_TORQ/extensions"
for ext in "$DOTFILES_PI/pi-extensions/"*.ts; do
  name=$(basename "$ext")
  ln -sf "$ext" "$PI_TORQ/extensions/$name"
  echo "  ✓ torq/ext:$name → $PI_TORQ/extensions/$name"
done

mkdir -p "$PI_TORQ/skills"
for skill_dir in "$DOTFILES_PI/skills"/*/; do
  name=$(basename "$skill_dir")
  ln -sfn "$skill_dir" "$PI_TORQ/skills/$name"
  echo "  ✓ torq/skill:$name → $PI_TORQ/skills/$name"
done

# 5. Claude Code agents — skills work as subagents in Claude Code
CLAUDE_AGENTS="$HOME/.claude/agents"
mkdir -p "$CLAUDE_AGENTS"
for skill_dir in "$DOTFILES_PI/skills"/*/; do
  name=$(basename "$skill_dir")
  ln -sfn "$skill_dir" "$CLAUDE_AGENTS/$name"
  echo "  ✓ claude:$name → $CLAUDE_AGENTS/$name"
done

echo ""
echo "Done."
echo ""
echo "  pi                   → personal work"
echo "  pi --profile torq    → Torq projects (with shared skills + extensions)"
echo "  claude               → skills available as subagents in ~/.claude/agents/"
