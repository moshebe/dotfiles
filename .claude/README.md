# AI Tooling Configuration Structure

This directory contains modular AI agent configuration (OpenCode, Claude Code).

## File Organization

```
~/.claude/
└── CLAUDE.md                    # 21 lines: Personal preferences (always loaded)

~/.dotfiles/.claude/
├── README.md                     # This file
├── OPENCODE.md                   # OpenCode setup guide (documentation, not loaded by AI)
└── frontend.md                   # 14 lines: Design guidelines (loaded in dotfiles context)

~/.dotfiles/<work-submodule>/.claude/
├── TEAM.md (or equivalent)       # Team conventions (loaded in work projects)
└── PERSONAL.md                   # Your private config (gitignored, loaded in work projects)
```

## Effective Loading per Context

| Context | Files Loaded | Total Lines |
|---------|-------------|-------------|
| Personal projects | Global only | 21 |
| Dotfiles work | Global + frontend.md | 35 |
| Work projects | Global + WORK.md + PERSONAL.md | ~143 |

**Previous**: 532 lines loaded everywhere
**Now**: 21-143 lines depending on context

## Benefits

1. ✅ **Attention budget preserved**: 143 max vs 532 original
2. ✅ **Context-aware**: Only loads relevant config
3. ✅ **No duplication**: Each rule lives in one place
4. ✅ **Team sync**: Work standards via git submodule
5. ✅ **Privacy**: Personal info gitignored
6. ✅ **Modularity**: Easy to maintain

## Best Practices

- **Global CLAUDE.md**: Keep under 15-20 lines (universal preferences)
- **Module files**: Keep under 60-80 lines each
- **Documentation**: Put in OPENCODE.md (not loaded by AI agent)
- **Personal info**: Put in gitignored PERSONAL.md files

## Migration

Original 532-line CLAUDE.md backed up to: `~/.claude/CLAUDE.md.backup`
