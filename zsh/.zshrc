HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt append_history hist_ignore_space hist_ignore_dups prompt_subst
setopt inc_append_history share_history hist_ignore_all_dups hist_reduce_blanks extended_history
setopt auto_cd interactive_comments multios

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv zsh)"
export PATH="\
/opt/homebrew/opt/uutils-coreutils/libexec/uubin:\
/opt/homebrew/opt/uutils-findutils/libexec/uubin:\
/opt/homebrew/opt/uutils-diffutils/libexec/uubin:\
/opt/homebrew/bin:\
/opt/homebrew/sbin:\
$HOME/.dotnet/tools:\
$HOME/.config/scripts:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/bin:\
/usr/sbin:\
/bin:\
/sbin"

autoload -Uz compinit && compinit
zmodload zsh/complist

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

precmd() {
    local exit_status=$?
    local glyph_color="%F{magenta}"
    [[ $exit_status -ne 0 ]] && glyph_color="%F{red}"
    
    local git_part=""
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n "$branch" ]] && git_part=" %F{cyan}on%f %B${branch}%b"
    
    PROMPT="%F{cyan}[%f%1~%F{cyan}]%f${git_part} ${glyph_color}β%f "
    printf '\e]7;file://%s%s\e\\' "$HOST" "$PWD"
}

if [ -x /opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors ]; then
    test -r ~/.dircolors && eval "$(/opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors -b ~/.dircolors)" || eval "$(/opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors -b)"
fi

alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias vim=nvim
alias neovide="open -a Neovide"

manh() {
    run-help "$1" 2>/dev/null | bat -l man -p
}

export MANPAGER="sh -c 'col -bx | bat -l man -p --color=always'"
export MANROFFOPT="-c"
export KUBECONFIG="$HOME/.kube/config"

if [[ -n "$NVIM" ]]; then
    nvim() {
        if [[ $# -eq 0 ]]; then
            open -a Neovide
        else
            command nvim --server "$NVIM" --remote "$@"
        fi
    }
fi

export PATH="$PATH:/Users/douglaslobo/.lmstudio/bin"
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
export PATH="/Users/douglaslobo/.rd/bin:$PATH"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null || :
