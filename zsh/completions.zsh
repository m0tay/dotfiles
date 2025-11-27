zmodload zsh/complist
autoload -Uz compinit

# Local plugin
fpath+=("$ZDOTDIR/plugins/zsh-completions")

if command -v brew &>/dev/null; then
  fpath+=("$HOMEBREW_PREFIX/share/zsh-completions")
  fpath+=("$HOMEBREW_PREFIX/share/zsh-abbr")
fi

_compdump="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zcompdump"
compinit -d "$_compdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' squeeze-slashes false

_comp_options+=(globdots)

zstyle ':completion::complete:*' tag-order 'commands' 'files'
