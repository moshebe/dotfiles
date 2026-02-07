# Dotfiles

My private dotfiles collection, used as a reference for me and others.

**To install the dotfiles**

```
git clone https://github.com/vic3lord/dotfiles ~/.dotfiles
cd ~/.dotfiles && make
```

## Package Management

Keep your system packages synced for easy migration. See [PACKAGES.md](PACKAGES.md) for details.

**Before migration:**
```bash
make sync  # Capture current Brew, Go, and npm packages
```

**On new machine:**
```bash
make install  # Install dotfiles + all packages
```
