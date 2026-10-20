export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
mkdir -p $XDG_CACHE_HOME/zsh $XDG_STATE_HOME/zsh

[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"

typeset -U path fpath
path=(
  $HOME/.local/bin
  $HOME/.config/scripts
  $HOME/.nix-profile/bin
  /etc/profiles/per-user/$USER/bin
  /run/current-system/sw/bin
  /nix/var/nix/profiles/default/bin
  /opt/homebrew/opt/uutils-{coreutils,findutils,diffutils}/libexec/uubin
  $HOME/.cargo/bin
  $HOME/.dotnet/tools
  $HOME/.lmstudio/bin
  $path
)
path=( ${^path}(N-/) )

fpath=(
  $HOME/.nix-profile/share/zsh/site-functions
  /etc/profiles/per-user/$USER/share/zsh/site-functions
  /run/current-system/sw/share/zsh/site-functions
  $fpath
)
fpath=( ${^fpath}(N-/) )

export EDITOR=nvim VISUAL=nvim
export LESS='-R -F -X -i -M'
export MANPAGER="sh -c 'col -bx | bat -l man -p --color=always'"
export MANROFFOPT="-c"
export HOMEBREW_NO_ANALYTICS=1 HOMEBREW_NO_ENV_HINTS=1

HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_all_dups hist_ignore_space hist_reduce_blanks extended_history
setopt auto_cd

# before the zstyle that reads LS_COLORS
if (( $+commands[dircolors] )); then
  if [[ -r ~/.dircolors ]]; then eval "$(dircolors -b ~/.dircolors)"; else eval "$(dircolors -b)"; fi
fi

autoload -Uz compinit; zmodload zsh/complist
() {
  setopt local_options extended_glob
  local dump=$XDG_CACHE_HOME/zsh/zcompdump
  if [[ -n $dump(#qN.mh+24) ]]; then compinit -d $dump; else compinit -C -d $dump; fi
}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:messages'    format ' %F{purple}-- %d --%f'
zstyle ':completion:*:warnings'    format ' %F{red}-- no matches found --%f'

_cache_comp() {
  (( $+commands[$1] )) || return 0
  local f=$XDG_CACHE_HOME/zsh/comp-$1.zsh
  [[ -s $f ]] || "$@" >| $f 2>/dev/null
  source $f
}
_cache_comp ng completion script

_prompt_precmd() {
  local exit_status=$?   # must stay first
  local glyph="%F{magenta}"; (( exit_status )) && glyph="%F{red}"
  local branch git_part=""
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [[ -n $branch ]] && git_part=" %F{cyan}on%f %B${branch}%b"
  [[ -n $IN_NIX_SHELL ]] && git_part+=" %F{yellow}(nix)%f"
  PROMPT="%F{cyan}[%f%1~%F{cyan}]%f${git_part} ${glyph}β%f "
  printf '\e]7;file://%s%s\e\\' "$HOST" "$PWD"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_precmd

alias ls='ls --color=auto' ll='ls -lah --color=auto' grep='grep --color=auto'
alias vim=nvim k=kubectl ff=fastfetch
alias neovide='open -a Neovide'
alias ndev='nix develop -c $SHELL'
alias nrs='sudo darwin-rebuild switch --flake ~/.config/nix-darwin'


manh() { run-help "$1" 2>/dev/null | bat -l man -p }

if [[ -n $NVIM ]]; then
  nvim() {
    if (( $# == 0 )); then open -a Neovide
    else command nvim --server "$NVIM" --remote "$@"; fi
  }
fi

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
[[ -r ~/.orbstack/shell/init.zsh ]] && source ~/.orbstack/shell/init.zsh

# must be last
for f in \
  $HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /etc/profiles/per-user/$USER/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
do [[ -r $f ]] && { source $f; break; } done
unset f
