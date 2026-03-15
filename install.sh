#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES"

# Detect OS
OS="$(uname -s)"

# Cross-platform packages
PACKAGES=(nvim fish tmux zed lazygit yazi scripts)

# macOS-only packages
if [ "$OS" = "Darwin" ]; then
    PACKAGES+=(ghostty aerospace kitty)
fi

for pkg in "${PACKAGES[@]}"; do
    if [ ! -d "$DOTFILES/$pkg" ]; then
        echo "Skipping $pkg (directory not found)"
        continue
    fi
    echo "Stowing $pkg..."
    rm -rf "$HOME/.config/$pkg"
    stow "$pkg"
done

echo "Done. Reload your shell."
