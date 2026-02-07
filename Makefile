DOTFILES = $(shell find -H $(CURDIR) -maxdepth 2 -name '*.symlink' -not -path "*.git*")

all: dotfiles install

.PHONY: dotfiles
dotfiles:
	@echo "installing dotfiles"
	$(foreach src,$(DOTFILES),$(shell ln -sfn $(src) $(HOME)/.$(shell basename $(subst .symlink,,$(src)))))

.PHONY: install
install:
	@echo "find the installers and run them iteratively"
	find . -name install.sh | xargs -I '{}' sh -c "{}"
	@echo "› brew bundle"
	brew bundle install --no-upgrade || echo "Some brew packages failed to install. Run 'brew bundle cleanup' to review."

.PHONY: sync
sync:
	@echo "› syncing package manifests"
	@echo "› updating Brewfile"
	brew bundle dump --force --describe --file=$(CURDIR)/Brewfile
	@echo "› updating go-packages.txt"
	@ls -1 $(shell go env GOPATH)/bin 2>/dev/null | while read bin; do \
		if command -v $$bin >/dev/null 2>&1; then \
			pkg=$$(go version -m $(shell go env GOPATH)/bin/$$bin 2>/dev/null | grep '^\tpath' | awk '{print $$2}'); \
			[ -n "$$pkg" ] && echo "$$pkg@latest"; \
		fi; \
	done | sort -u > $(CURDIR)/go-packages.txt.tmp && \
	(echo "# Go packages installed via 'go install'" && \
	 echo "# Install with: xargs -n 1 go install < go-packages.txt" && \
	 echo "" && \
	 cat $(CURDIR)/go-packages.txt.tmp) > $(CURDIR)/go-packages.txt && \
	rm $(CURDIR)/go-packages.txt.tmp
	@echo "› updating npm-global.txt"
	@(echo "# NPM global packages" && \
	  echo "# Install with: xargs npm install -g < npm-global.txt" && \
	  echo "" && \
	  npm list -g --depth=0 --parseable 2>/dev/null | tail -n +2 | xargs -n1 basename | grep -v '^npm$$') > $(CURDIR)/npm-global.txt
	@echo "✓ package manifests synced"

.PHONY: restore-packages
restore-packages:
	@echo "› restoring packages from manifests"
	@echo "› installing Homebrew packages"
	brew bundle install --no-upgrade
	@echo "› installing Go packages"
	@grep -v '^#' $(CURDIR)/go-packages.txt | grep -v '^$$' | xargs -n 1 go install
	@echo "› installing npm global packages"
	@grep -v '^#' $(CURDIR)/npm-global.txt | grep -v '^$$' | xargs npm install -g
	@echo "✓ packages restored"
