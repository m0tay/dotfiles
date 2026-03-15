#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES"

# Detect OS
OS="$(uname -s)"

# Cross-platform packages
PACKAGES=(fish nvim tmux zed lazygit yazi scripts)

# macOS-only packages
if [ "$OS" = "Darwin" ]; then
    PACKAGES+=(aerospace kitty)

    # Create machine-specific fish vars (gitignored)
    LOCAL_FISH="$HOME/.config/fish/config.local.fish"
    if [ ! -f "$LOCAL_FISH" ]; then
        echo "Creating $LOCAL_FISH..."
        cat > "$LOCAL_FISH" << 'EOF'
set -gx BOOKS "$HOME/Library/Mobile Documents/iCloud~com~apple~iBooks/Documents"
set -gx MONO_GAC_PREFIX "/opt/homebrew"
set -gx DOTNET_ROOT /opt/homebrew/Cellar/dotnet/10.0.102/libexec
set -gx DOTNET_ROOT_ARM64 $DOTNET_ROOT
EOF
    fi
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
