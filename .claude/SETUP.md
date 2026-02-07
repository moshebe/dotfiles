# Claude Code Setup Guide

Complete guide for configuring Claude Code from scratch.

## Installed CLI Tools

✅ Core tools: `gtrace`, `gcloud`, `gh`, `uv`, `acli`, `ldcli`

Install via:
```bash
make install  # From ~/.dotfiles (installs Brewfile)
```

---

## settings.json Configuration

Location: `~/.claude/settings.json`

### Complete Example

```json
{
  "includeCoAuthoredBy": true,
  "permissions": {
    "allow": [
      "Bash(chmod:*)",
      "Bash(echo:*)",
      "Bash(cp:*)",
      "Bash(curl:*)",
      "Bash(deadcode:*)",
      "Bash(docker:*)",
      "Bash(docker exec:*)",
      "Bash(docker logs:*)",
      "Bash(docker restart:*)",
      "Bash(find:*)",
      "Bash(gcloud config:*)",
      "Bash(gcloud monitoring time-series list:*)",
      "Bash(gcloud pubsub subscriptions describe:*)",
      "Bash(gcloud pubsub subscriptions list:*)",
      "Bash(gcloud pubsub subscriptions pull:*)",
      "Bash(gcloud pubsub topics describe:*)",
      "Bash(gh:*)",
      "Bash(git:*)",
      "Bash(go:*)",
      "Bash(grep:*)",
      "Bash(head:*)",
      "Bash(kubectl get:*)",
      "Bash(kubectl logs:*)",
      "Bash(ldcli:*)",
      "Bash(ldcli flags list:*)",
      "Bash(ls:*)",
      "Bash(lsof:*)",
      "Bash(make:*)",
      "Bash(mkdir:*)",
      "Bash(mv:*)",
      "Bash(npm:*)",
      "Bash(npx:*)",
      "Bash(pkill:*)",
      "Bash(poetry:*)",
      "Bash(PORT=:*)",
      "Bash(protodep up:*)",
      "Bash(python:*)",
      "Bash(python3:*)",
      "Bash(rg:*)",
      "Bash(sed:*)",
      "Bash(source:*)",
      "Bash(sqlite3:*)",
      "Bash(tail:*)",
      "Bash(touch:*)",
      "Bash(uv:*)",
      "Bash(gofmt:*)",
      "Bash(cat:*)",
      "Bash(kt:*)",
      "Edit",
      "Read(//Users/kostya/work/common/**)",
      "Update(*)",
      "Update(*:*)",
      "WebSearch",
      "Write",
      "Write(*)"
    ],
    "deny": [],
    "defaultMode": "plan"
  },
  "model": "opus",
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Glass.aiff"
          },
          {
            "type": "command",
            "command": "terminal-notifier -title \"🔔 Claude Code\" -message \"Claude needs your input\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Glass.aiff"
          },
          {
            "type": "command",
            "command": "terminal-notifier -title \"✅ Claude Code\" -message \"The task has been completed\""
          }
        ]
      }
    ]
  },
  "statusLine": {
    "type": "command",
    "command": "/Users/kostya/personal/claude-status/claude-status --prefix torq --prefix-color green",
    "padding": 0
  },
  "enabledPlugins": {
    "code-review@claude-plugins-official": true,
    "code-simplifier@claude-plugins-official": true,
    "commit-commands@claude-plugins-official": true,
    "compound-engineering@every-marketplace": true,
    "double-shot-latte@superpowers-marketplace": false,
    "elements-of-style@superpowers-marketplace": true,
    "frontend-design@claude-plugins-official": true,
    "gopls-lsp@claude-plugins-official": true,
    "pr-review-toolkit@claude-plugins-official": true,
    "pyright-lsp@claude-plugins-official": true,
    "ralph-loop@claude-plugins-official": true,
    "ralph-wiggum@claude-plugins-official": true,
    "security-guidance@claude-plugins-official": true,
    "superpowers@superpowers-marketplace": true,
    "swift-lsp@claude-plugins-official": true,
    "torq-observability@torq-ai-dev-tools": true,
    "ccc-skills@ccc": true,
    "typescript-lsp@claude-plugins-official": true
  },
  "extraKnownMarketplaces": {
    "torq-ai-dev-tools": {
      "source": {
        "source": "directory",
        "path": "/Users/kostya/.claude/plugins/marketplaces/torqio-ai-dev-tools"
      }
    }
  },
  "alwaysThinkingEnabled": true
}
```

---

## Desktop Notifications

Get notified when Claude needs input or finishes.

**Prerequisites:**
```bash
brew install terminal-notifier
```

**Configuration** (add to settings.json):
```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Glass.aiff"
          },
          {
            "type": "command",
            "command": "terminal-notifier -title \"🔔 Claude Code\" -message \"Claude needs your input\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Glass.aiff"
          },
          {
            "type": "command",
            "command": "terminal-notifier -title \"✅ Claude Code\" -message \"The task has been completed\""
          }
        ]
      }
    ]
  }
}
```

---

## Status Line (Optional)

Install from: https://github.com/kostyay/claude-status

Custom status line at top of terminal:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/path/to/claude-status --prefix torq --prefix-color green",
    "padding": 0
  }
}
```

---

## Extended Thinking

Enable extended thinking mode:

```json
{
  "alwaysThinkingEnabled": true
}
```

---

## Enabled Plugins

Plugins extend Claude's capabilities with skills, agents, and MCP servers.

### Currently Enabled

| Plugin | Marketplace | Purpose |
|--------|-------------|---------|
| `commit-commands` | claude-plugins-official | `/commit`, `/commit-push-pr` |
| `pr-review-toolkit` | claude-plugins-official | PR review agents |
| `code-review` | claude-plugins-official | Code review automation |
| `code-simplifier` | claude-plugins-official | Simplify code |
| `frontend-design` | claude-plugins-official | Frontend design patterns |
| `security-guidance` | claude-plugins-official | Security best practices |
| `ralph-loop` | claude-plugins-official | Iterative agent loop |
| `gopls-lsp` | claude-plugins-official | Go language server |
| `pyright-lsp` | claude-plugins-official | Python language server |
| `typescript-lsp` | claude-plugins-official | TypeScript language server |
| `superpowers` | superpowers-marketplace | Workflow skills |
| `elements-of-style` | superpowers-marketplace | Writing style guide |
| `compound-engineering` | every-marketplace | Research/design/review agents |
| `torq-observability` | torq-ai-dev-tools | Torq GCP debugging |

### Enable/Disable in settings.json

```json
{
  "enabledPlugins": {
    "commit-commands@claude-plugins-official": true,
    "pr-review-toolkit@claude-plugins-official": true,
    "gopls-lsp@claude-plugins-official": true,
    "superpowers@superpowers-marketplace": true
  }
}
```

### Custom Marketplace (Internal Plugins)

For internal/private plugins (like torqio/ai-dev-tools):

**Note:** Clone locally if private repo has access issues.

```json
{
  "extraKnownMarketplaces": {
    "torq-ai-dev-tools": {
      "source": {
        "source": "directory",
        "path": "/Users/you/.claude/plugins/marketplaces/torqio-ai-dev-tools"
      }
    }
  }
}
```

---

## Custom Commands

Location: `~/.claude/commands/`

Create `.md` files for custom slash commands.

### Example: `/kt-run`

File: `~/.claude/commands/kt-run.md`

```markdown
Use kt to implement all tasks.

1. Run `kt ready` to see available tasks
2. Pick top priority task, `kt start <id>`
3. Implement the task
4. `kt close <id>` when done
5. Repeat until all tasks complete

## kt reference
```sh
kt ready                    # show actionable tasks
kt show <id>                # view task details
kt start|close <id>         # workflow transitions
kt add-note <id> "text"     # log progress
kt ls --status=in_progress  # see active work
```
```

Usage: Type `/kt-run` in Claude Code.

---

## Custom Skills

Location: `~/.claude/skills/<skill-name>/SKILL.md`

Skills are like commands but more sophisticated - they define workflows, include scripts, and provide detailed instructions.

### Example: Jira Ticket Creator

Directory: `~/.claude/skills/jira-ticket-creator/`

```
jira-ticket-creator/
├── SKILL.md
└── scripts/
    └── create_ticket_and_branch.py
```

`SKILL.md` frontmatter:
```markdown
---
name: jira-ticket-creator
description: Create Jira tickets with descriptive summaries and branch setup.
---

# Jira Ticket Creator
...workflow instructions...
```

### Example: Browser Automation

Directory: `~/.claude/skills/agent-browser/`

Provides commands like:
- `agent-browser open <url>`
- `agent-browser snapshot -i`
- `agent-browser click @e1`
- `agent-browser fill @e2 "text"`

---

## Installation Steps (New Machine)

### Step 1: Create Directory Structure

```bash
mkdir -p ~/.claude/{commands,skills,plugins/marketplaces}
```

### Step 2: Clone Dotfiles

```bash
git clone https://github.com/moshebe/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install  # Installs packages + symlinks dotfiles
```

### Step 3: Copy settings.json Template

```bash
cp ~/.dotfiles/.claude/SETUP.md ~/.claude/
# Edit settings.json with your preferences
```

### Step 4: Install Plugins

```bash
# Via Claude Code
claude /plugins install commit-commands@claude-plugins-official
claude /plugins install pr-review-toolkit@claude-plugins-official
claude /plugins install superpowers@superpowers-marketplace

# Add torq-ai-dev-tools marketplace (if Torq employee)
# See extraKnownMarketplaces section above
```

### Step 5: Install Notification Tool (macOS)

```bash
brew install terminal-notifier
```

---

## Key Features Summary

| Feature | Location | Purpose |
|---------|----------|---------|
| Global instructions | `~/.claude/CLAUDE.md` | Personal preferences (15 lines) |
| Dotfiles docs | `~/.dotfiles/.claude/` | Setup guides, frontend rules |
| Torq conventions | `~/.dotfiles/torq/.claude/TORQ.md` | Team standards |
| Permissions | `settings.json` | Pre-approve safe commands |
| Hooks | `settings.json` | Desktop notifications |
| Plan mode | `settings.json` | Start in planning mode |
| Plugins | `settings.json` | Enable/disable plugins |
| Commands | `commands/*.md` | Custom slash commands |
| Skills | `skills/*/SKILL.md` | Complex workflows |

---

## Tips

1. **Plan mode default** - Safer, forces thinking before doing
2. **Notification hooks** - Essential for background tasks
3. **Selective permissions** - Allow read ops freely, restrict writes
4. **LSP plugins** - Enable for your languages (Go, Python, TS)
5. **Custom commands** - Automate repetitive workflows
6. **settings.local.json** - Machine-specific overrides (don't commit)
7. **Modular CLAUDE.md** - Use subdirectory files for module-specific rules
