# GitHub CLI Skill

Use `gh` for all GitHub operations. Never construct GitHub URLs manually.

## PRs
```bash
gh pr list                          # list open PRs
gh pr view [number]                 # view PR description
gh pr diff [number]                 # view PR diff
gh pr create --title "..." --body "..."
gh pr merge --squash
gh pr checks                        # CI status for current PR
```

## Issues
```bash
gh issue list --assignee @me
gh issue view <number>
gh issue create --title "..." --body "..."
```

## CI / Workflows
```bash
gh run list                         # recent runs
gh run view <id>                    # run details + logs
gh run view <id> --log-failed       # only failed step logs
gh run rerun <id> --failed          # rerun failed jobs only
```

## Repos
```bash
gh repo clone org/repo              # clone to current dir
gh repo view --web                  # open in browser
```

## API (when gh commands aren't enough)
```bash
gh api repos/{owner}/{repo}/pulls   # raw REST API
gh api graphql -f query='...'       # GraphQL
```
