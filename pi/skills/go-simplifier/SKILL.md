# Go Code Simplifier Skill

Apply when reviewing or simplifying Go code. Target: Go 1.21+, idiomatic style.

## Core Principles
- Simplest solution that satisfies requirements — resist over-engineering
- Standard library first; avoid dependencies for problems stdlib solves
- Explicit > clever; readable > compact
- Error handling: check and handle, never ignore; wrap with context using `fmt.Errorf("...: %w", err)`

## Common Simplifications

### Replace verbose nil checks with early returns
```go
// before
if err != nil {
    return err
}
// after — same thing, keep it
```

### Use table-driven tests
```go
tests := []struct {
    name string
    input string
    want  string
}{
    {"empty", "", ""},
    {"basic", "foo", "foo"},
}
for _, tt := range tests {
    t.Run(tt.name, func(t *testing.T) { ... })
}
```

### Prefer named returns only for defer-based cleanup, not general use

### Interface sizing: keep interfaces small (1-3 methods)

### Avoid premature abstraction
- Three similar call sites don't require a helper
- Helpers earn their place when they encapsulate non-obvious logic

## What NOT to change
- Don't add godoc to unexported functions unless logic is non-obvious
- Don't rename variables just to match a convention if the existing name is clear
- Don't restructure working error-handling patterns
