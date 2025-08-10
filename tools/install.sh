#!/bin/bash

set -e

echo "Installing additional development tools..."

# Install Rust and Cargo
if ! command -v rustup &> /dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Install useful Rust tools
echo "Installing Rust-based tools..."
cargo install \
    bat \
    exa \
    fd-find \
    ripgrep \
    du-dust \
    duf \
    procs \
    starship \
    zoxide \
    git-delta \
    difftastic \
    tokei \
    hyperfine

# Install Node.js tools
echo "Installing Node.js tools..."
npm install -g \
    typescript \
    ts-node \
    prettier \
    eslint \
    http-server \
    json-server \
    npm-check-updates \
    tldr \
    serve \
    vercel \
    yarn \
    pnpm

# Install Python tools
echo "Installing Python tools..."
pip3 install --user \
    pipenv \
    poetry \
    black \
    flake8 \
    mypy \
    pytest \
    httpie \
    youtube-dl \
    jupyterlab \
    ipython \
    pre-commit

# Install Go tools
echo "Installing Go tools..."
go install \
    golang.org/x/tools/gopls@latest \
    github.com/go-delve/delve/cmd/dlv@latest \
    github.com/golangci/golangci-lint/cmd/golangci-lint@latest \
    github.com/air-verse/air@latest \
    github.com/jesseduffield/lazygit@latest

# Install additional tools
if ! command -v fzf &> /dev/null; then
    echo "Installing fzf..."
    $(brew --prefix)/opt/fzf/install --all
fi

# Install Starship prompt if not already installed
if ! command -v starship &> /dev/null; then
    echo "Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Install Docker Compose v2 if not already installed
if ! command -v docker-compose &> /dev/null; then
    echo "Installing Docker Compose v2..."
    mkdir -p ~/.docker/cli-plugins/
    curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o ~/.docker/cli-plugins/docker-compose
    chmod +x ~/.docker/cli-plugins/docker-compose
fi

# Install GitHub CLI extensions
if command -v gh &> /dev/null; then
    echo "Installing GitHub CLI extensions..."
    gh extension install github/gh-copilot
    gh extension install dlvhdr/gh-dash
    gh extension install mislav/gh-branch
    gh extension install vilmibm/gh-screensaver
fi

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Development tools installation complete!"
