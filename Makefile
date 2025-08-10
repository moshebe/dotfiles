# Makefile for dotfiles installation and management

SHELL := /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
DOTFILES := $(shell find -H "$(DOTFILES_DIR)" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
INSTALLERS := $(shell find "$(DOTFILES_DIR)" -name 'install.sh')
UNAME := $(shell uname -s)

.PHONY: all
all: install ## Install everything (default)

.PHONY: help
help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: install
install: pre-install symlinks homebrew tools post-install ## Run full installation

.PHONY: pre-install
pre-install: ## Run pre-installation checks
	@echo "==> Running pre-installation checks..."
	@if [ "$(UNAME)" != "Darwin" ]; then \
		echo "Error: This dotfiles setup is designed for macOS"; \
		exit 1; \
	fi
	@if ! command -v git >/dev/null 2>&1; then \
		echo "Error: git is required but not installed."; \
		exit 1; \
	fi

.PHONY: symlinks
symlinks: ## Create symlinks for dotfiles
	@echo "==> Creating symlinks..."
	@for file in $(DOTFILES); do \
		target="$$HOME/.`basename $${file%.*}`"; \
		if [ -e "$$target" ]; then \
			echo "Backing up $$target to $$target.backup"; \
			mv "$$target" "$$target.backup" 2>/dev/null || true; \
		fi; \
		echo "Linking $$file to $$target"; \
		ln -sfn "$$file" "$$target"; \
	done

.PHONY: homebrew
homebrew: ## Install Homebrew and packages
	@echo "==> Setting up Homebrew..."
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@echo "Updating Homebrew..."
	@brew update
	@echo "Installing Homebrew packages..."
	@brew bundle --file $(DOTFILES_DIR)/Brewfile || { \
		echo "Error: Homebrew bundle failed. Check the Brewfile and try again."; \
		exit 1; \
	}

.PHONY: tools
tools: ## Install additional development tools
	@echo "==> Installing development tools..."
	@for installer in $(INSTALLERS); do \
		echo "Running $$installer..."; \
		bash "$$installer" || { \
			echo "Error: Installation script $$installer failed."; \
			exit 1; \
		}; \
	done

.PHONY: post-install
post-install: ## Run post-installation tasks
	@echo "==> Running post-installation tasks..."
	@echo "Cleaning up..."
	@brew cleanup
	@echo "Installation complete! Please restart your terminal."

.PHONY: update
update: ## Update all tools and packages
	@echo "==> Updating system..."
	@brew update
	@brew upgrade
	@brew cleanup
	@echo "==> Updating development tools..."
	@source ~/.cargo/env && rustup update
	@cargo install-update -a
	@npm update -g
	@pip3 list --outdated | awk 'NR>2 {print $$1}' | xargs -r -n1 pip3 install -U
	@echo "Updating Go packages..."
	@if [ -f go.mod ]; then go list -f '{{if not (or .Main .Indirect)}}{{.Path}}{{end}}' -m all | xargs -I{} go get -u {}; else echo "No go.mod found, skipping Go package updates"; fi
	@echo "Updating Go tools..."
	@go install golang.org/x/tools/gopls@latest
	@go install github.com/go-delve/delve/cmd/dlv@latest
	@go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	@go install github.com/air-verse/air@latest
	@go install github.com/jesseduffield/lazygit@latest
	@echo "Update complete!"

.PHONY: clean
clean: ## Clean up temporary files and backups
	@echo "==> Cleaning up..."
	@find "$(DOTFILES_DIR)" -name "*.backup" -delete
	@find "$(DOTFILES_DIR)" -name "*.tmp" -delete
	@find "$(DOTFILES_DIR)" -name "*.swp" -delete
	@echo "Cleanup complete!"

.PHONY: doctor
doctor: ## Check system for potential problems
	@echo "==> Running system checks..."
	@echo "Checking Homebrew..."
	@brew doctor || true
	@echo "Checking for broken symlinks..."
	@find -L "$(HOME)" -maxdepth 1 -type l -exec ls -l {} \;
	@echo "Checking shell configuration..."
	@zsh -n "$(HOME)/.zshrc"
	@echo "System check complete!"