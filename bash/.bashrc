case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend checkwinsize

eval "$(/opt/homebrew/bin/brew shellenv bash)"
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

__prompt() {
    local last=$?
    local cyan='\[\e[36m\]'
    local magenta='\[\e[35m\]'
    local red='\[\e[31m\]'
    local bold='\[\e[1m\]'
    local reset='\[\e[0m\]'
    
    local glyph_color=$magenta
    [[ $last -ne 0 ]] && glyph_color=$red
    
    local git_part=""
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n "$branch" ]] && git_part=" ${cyan}on${reset} ${bold}${branch}${reset}"
    
    PS1="${cyan}[${reset}\W${cyan}]${reset}${git_part} ${glyph_color}β${reset} "
    printf '\e]7;file://%s%s\e\\' "$HOSTNAME" "$PWD"
}
PROMPT_COMMAND=__prompt

if [ -x /opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors ]; then
    test -r ~/.dircolors && eval "$(/opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors -b ~/.dircolors)" || eval "$(/opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors -b)"
fi

alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias vim=nvim
alias neovide="open -a Neovide"
alias manh='f(){ help -m "$1" | bat -l man -p; }; f'

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

export MANPAGER="sh -c 'col -bx | bat -l man -p --color=always'"
export MANROFFOPT="-c"

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

if [[ -n "$NVIM" ]]; then
    nvim() {
        if [[ $# -eq 0 ]]; then
            open -a Neovide
        else
            command nvim --server "$NVIM" --remote "$@"
        fi
    }
fi

export KUBECONFIG="$HOME/.kube/config"
export PATH="$PATH:/Users/douglaslobo/.lmstudio/bin"
export PATH="/Users/douglaslobo/.rd/bin:$PATH"
. "$HOME/.cargo/env"
