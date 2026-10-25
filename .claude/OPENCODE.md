# OpenCode Setup Guide

Complete guide for configuring OpenCode from scratch on a new machine.

## Quick Install

```bash
git clone https://github.com/moshebe/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install   # brew bundle + dotfiles symlinks + skills
```

---

## Directory Structure

```
~/.dotfiles/opencode/
├── install.sh          # wires opencode.json + skills
├── opencode.json       # versioned config (symlinked to ~/.config/opencode/)
└── skills/             # personal skills (symlinked to ~/.config/opencode/skills/)
    ├── github/         # gh CLI reference
    └── go-simplifier/  # idiomatic Go patterns

~/.config/opencode/     # runtime dir (managed by install.sh)
├── opencode.json       # -> ~/.dotfiles/opencode/opencode.json
└── skills/             # symlinked personal + work-overlay skills
```

---

## opencode.json

Location: `~/.dotfiles/opencode/opencode.json` (symlinked to `~/.config/opencode/opencode.json`)

Key sections:

### Providers
- **Anthropic** — set `ANTHROPIC_API_KEY` in shell (via `claude-profile` switcher)
- **Ollama** — local models at `http://localhost:11434/v1`; configured models: Gemma4, Qwen3.6, Devstral, DeepSeek R1

### Permissions
Read-only ops pre-approved globally:
```json
"permission": {
  "read": "allow",
  "glob": "allow",
  "grep": "allow",
  "list": "allow",
  "todoread": "allow",
  "todowrite": "allow",
  "lsp": "allow"
}
```

### MCP Servers
| Server | Type | Purpose |
|--------|------|---------|
| `atlassian` | local (npx) | Jira + Confluence |
| `notion` | remote OAuth | Notion workspace |
| `slack` | remote OAuth | Slack (URL via `$MCP_SLACK_URL`) |
| `google-drive-and-email` | remote | Drive + Gmail (URL via `$MCP_GDRIVE_URL`) |
| `incident.io` | remote OAuth | Incident management |

Work-only MCP servers live in the private work overlay and are merged in via `$OPENCODE_CONFIG`.

---

## Skills

Skills auto-trigger based on their `description` field. No slash command needed.

### Personal Skills (in dotfiles)
| Skill | Triggers On |
|-------|------------|
| `github` | `gh pr`, PR operations, CI runs, GitHub issues |
| `go-simplifier` | Go code review/simplify requests |

### Work Skills (optional)
Linked by `opencode/install.sh` from the work overlay submodule and `$AI_DEV_TOOLS`, when present.

### Adding a New Skill
```
~/.dotfiles/opencode/skills/<skill-name>/
└── SKILL.md   # YAML frontmatter: name + description required
```

Frontmatter template:
```yaml
---
name: skill-name
description: >
  When to load this skill. Include trigger phrases users might say.
---
```

Run `make opencode` to symlink the new skill.

---

## API Key Management (claude-profile switcher)

The `claude-profile` function in your shell switches `ANTHROPIC_API_KEY`:

```bash
claude-profile work          # switch to work key
claude-profile personal      # switch to personal key
claude-profile ai-sre-dev    # switch to ai-sre-dev key
claude-whoami                # show active profile + key prefix
```

Profile files live in `~/.dotfiles/zsh/claude-profiles/` (gitignored).
Both OpenCode and Claude Code use `ANTHROPIC_API_KEY` — the switcher works for both.

---

## CLAUDE.md Hierarchy

| File | Purpose | Lines |
|------|---------|-------|
| `~/.claude/CLAUDE.md` | Global personal rules | ~21 |
| `~/.dotfiles/.claude/frontend.md` | Frontend design rules | ~15 |
| `<work-submodule>/.claude/*.md` | Team conventions (private) | — |

Loaded via `@` references in project `CLAUDE.md` files.

---

## Installation: New Machine

### Step 1: Clone + install packages
```bash
git clone https://github.com/moshebe/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install
```

### Step 2: Install OpenCode
```bash
brew install opencode   # or via the install script at opencode.ai
```

### Step 3: Wire OpenCode config
```bash
make opencode
```

### Step 4: Set up API key profiles
```bash
mkdir -p ~/.dotfiles/zsh/claude-profiles
# Create profile files: work, personal, ai-sre-dev
# Each file contains: export ANTHROPIC_API_KEY="sk-ant-..."
```

### Step 5: Work overlay (optional)
```bash
# Set AI_DEV_TOOLS in the private work overlay, then:
make opencode   # re-run to also link work skills
```

### Step 6: Authenticate MCP servers
```bash
# On first use, OpenCode will prompt OAuth for: notion, slack, atlassian, etc.
# Set env vars in ~/.localrc:
export MCP_SLACK_URL="..."
export MCP_GDRIVE_URL="..."
```

---

## Tips

1. **Skills over plugins** — OpenCode uses skills (SKILL.md), not Claude Code plugins
2. **`make opencode`** — re-run whenever you add a skill or update opencode.json
3. **`make upgrade-plugins`** — pulls latest `$AI_DEV_TOOLS` (set in work overlay)
4. **Ollama for local work** — set model to `qwen3.6:35b` for offline/private code
5. **Profile switcher** — `claude-profile work` before work sessions
