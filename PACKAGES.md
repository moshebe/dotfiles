# Package Management

This directory contains package manifests for reproducible system setup.

## Files

- **`Brewfile`**: Homebrew formulae, casks, and taps (generated with descriptions)
- **`go-packages.txt`**: Go packages installed via `go install`
- **`npm-global.txt`**: Global npm packages

## Commands

### Sync Current System State
Capture all currently installed packages to manifests:
```bash
make sync
```

This will:
- Update `Brewfile` with all brew packages/casks/taps (with descriptions)
- Update `go-packages.txt` with Go binaries
- Update `npm-global.txt` with global npm packages

### Restore Packages on New Machine
Install all packages from manifests:
```bash
make restore-packages
```

This will:
- Install all Homebrew packages from `Brewfile`
- Install all Go packages from `go-packages.txt`
- Install all npm globals from `npm-global.txt`

### Manual Commands

#### Homebrew
```bash
# Install from Brewfile
brew bundle install

# Update Brewfile from current system
brew bundle dump --force --describe
```

#### Go Packages
```bash
# Install all Go packages
xargs -n 1 go install < go-packages.txt

# List installed Go binaries
ls -1 $(go env GOPATH)/bin
```

#### NPM Global Packages
```bash
# Install all npm globals
xargs npm install -g < npm-global.txt

# List current globals
npm list -g --depth=0
```

## Best Practices

1. **Before system migration**: Run `make sync` to capture current state
2. **After major package installations**: Run `make sync` to keep manifests current
3. **On new machine**: Run `make install` (includes dotfiles + packages)
4. **Regular maintenance**: Periodically run `make sync` to keep manifests up-to-date

## Package Manager Versions

As of last sync:
- Homebrew: `brew --version`
- Go: `go version`
- Node/NPM: `node --version` / `npm --version`
