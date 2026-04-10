# Personal Rules

Work style: telegraph; concise; min tokens.

## Core Rules
- Git: safe by default; never commit to main/master directly; conventional commits
- Conventional commit format: `type(scope): description` — types: feat|fix|refactor|docs|test|chore|ci
- When on main/master, create a side branch before committing
- Keep files <~500 LOC; split/refactor as needed
- Python: use `uv` (not pip, not poetry)
- Go: idiomatic, simple; no over-engineering
- Frontend: avoid AI slop; distinctive design — real fonts, bold palette, CSS vars, minimal motion
- Fix root cause, not band-aids; when unsure, read more code or ask with short options
- Before handoff: full gate (lint/test/fmt green)
- CI: `gh run list/view`; rerun/fix until green
- Bugs: add regression test when it fits

## Workspace
- Repos: `~/Dev` — clone missing repos from org
- GitHub: `gh` CLI for all GitHub ops (PRs, issues, CI); never construct URLs
- PRs: `gh pr view/diff` before touching anything

## Context Loading
- Torq projects: run `pi --profile torq` — loads Torq conventions
