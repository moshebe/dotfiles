#!/bin/bash

set -e

echo "Setting up Neovim..."

# Create necessary directories
mkdir -p ~/.config
mkdir -p ~/.local/share/nvim/lazy

# Install lazy.nvim (package manager)
if [ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/lazy/lazy.nvim ]; then
  echo "Installing lazy.nvim..."
  git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/lazy/lazy.nvim
fi

# Link configuration
if [ ! -e ~/.config/nvim ]; then
  echo "Linking Neovim configuration..."
  ln -s $HOME/.dotfiles/nvim/config ~/.config/nvim
fi

# Install language servers and tools via Mason
echo "Installing language servers and tools..."
nvim --headless "+MasonInstall lua-language-server gopls rust-analyzer typescript-language-server pyright json-lsp yaml-language-server bash-language-server dockerfile-language-server terraform-ls" +qa

# Install treesitter parsers
echo "Installing treesitter parsers..."
nvim --headless "+TSInstall lua vim vimdoc javascript typescript go rust python bash markdown yaml json toml" +qa

echo "Neovim setup complete!"