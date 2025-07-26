# Homebrew prefix fallback
# HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
HOMEBREW_PREFIX="$(brew --prefix)"

source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "$HOMEBREW_PREFIX/share/zsh-autopair/autopair.zsh"

source "$HOMEBREW_PREFIX/share/zsh-you-should-use/you-should-use.plugin.zsh"

source "$HOMEBREW_PREFIX/share/zsh-colored-man-pages/colored-man-pages.plugin.zsh"

source "$HOMEBREW_PREFIX/share/zsh-abbr/zsh-abbr.zsh"
