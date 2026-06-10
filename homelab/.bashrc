# Exit if not interactive
[[ $- != *i* ]] && return

OS_TYPE="$(uname)"
IS_DARWIN=false
IS_FREEBSD=false
IS_LINUX=false

[[ "$OS_TYPE" == "Darwin" ]] && IS_DARWIN=true
[[ "$OS_TYPE" == "FreeBSD" ]] && IS_FREEBSD=true
[[ "$OS_TYPE" == "Linux" ]] && IS_LINUX=true

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

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
    if command -v git &>/dev/null; then
        local branch
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        [[ -n "$branch" ]] && git_part=" ${cyan}on${reset} ${bold}${branch}${reset}"
    fi
    
    PS1="${cyan}[${reset}\W${cyan}]${reset}${git_part} ${glyph_color}β${reset} "
}
PROMPT_COMMAND=__prompt

if $IS_DARWIN; then
    alias ls='ls -G'
    alias ll='ls -lahG'
else
    # Linux/FreeBSD
    if command -v dircolors &>/dev/null; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias ll='ls -lah --color=auto'
    else
        alias ls='ls -l'
        alias ll='ls -lah'
    fi
fi

if command -v grep &>/dev/null; then
    alias grep='grep --color=auto'
fi

if command -v nvim &>/dev/null; then
    alias vim='nvim'
elif command -v vi &>/dev/null; then
    alias vim='vi'
fi

if command -v bat &>/dev/null && command -v col &>/dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p --color=always'"
fi

[ -r ~/.bash_aliases ] && source ~/.bash_aliases

if ! shopt -oq posix; then
    # Try standard locations
    if [ -r /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -r /etc/bash_completion ]; then
        source /etc/bash_completion
    elif [ -r /usr/local/share/bash-completion/bash_completion ]; then
        # FreeBSD via ports
        source /usr/local/share/bash-completion/bash_completion
    fi
fi
