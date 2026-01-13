# 🚀 Dotfiles

A comprehensive, modern dotfiles setup for macOS development. This configuration provides a powerful and efficient development environment with the latest tools and best practices.

## 🚀 Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Install everything:
   ```bash
   make
   ```

## ⚡ Performance

This dotfiles configuration is optimized for **fast shell startup**:
- **Shell startup time**: ~16ms (91.7x faster than standard configuration)
- **Lazy-loading**: Heavy tools (NVM, jenv, pyenv, gcloud SDK) load only when needed
- **Cached completions**: Completion system recompiles only once per day

See [OPTIMIZATIONS.md](./OPTIMIZATIONS.md) for detailed performance analysis.

## 🎯 Features

### Enhanced Prompt (Starship)
- Shows current **GCP project** and region
- Displays **Kubernetes context** and namespace
- Git branch, status, and changes
- Smart language version display (Node/Python/Go/Rust)
- Command execution time tracking

### Lazy-Loaded Tools
These tools load automatically on first use (one-time ~1.5s delay):
- `node`, `npm`, `npx`, `nvm` (NVM)
- `java`, `javac`, `jenv` (jenv)
- `python`, `pip`, `pyenv` (pyenv)
- `gcloud`, `gsutil`, `bq` (Google Cloud SDK)

## 🎨 Customization

### Adding Your Own Configuration

1. Create a new directory for your tool:
   ```bash
   mkdir ~/.dotfiles/your-tool
   ```

2. Add your configuration files:
   - Use `.symlink` extension for files that should be symlinked to home
   - Add `install.sh` for any installation steps
   - Add `*.zsh` files for ZSH configuration and aliases

### Modifying Existing Configuration

- Edit files in `~/.dotfiles` directory
- Run `make symlinks` to update symlinks
- Source `~/.zshrc` to apply changes

## 🔄 Updating

To update all tools and packages:

```bash
make update
```

## 🧰 Available Make Commands

- `make`: Install everything
- `make help`: Show available commands
- `make update`: Update all tools and packages
- `make clean`: Clean up temporary files
- `make doctor`: Check system for potential problems

## 📁 Directory Structure

```
~/.dotfiles/
├── alacritty/          # Terminal configuration
├── bin/                # Custom scripts
├── git/                # Git configuration
├── nvim/               # Neovim configuration
├── tmux/               # Tmux configuration
├── tools/              # Additional tools
├── zsh/                # ZSH configuration
├── Brewfile            # Homebrew packages
└── Makefile           # Installation scripts
```
