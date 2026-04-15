# ~/.bashrc
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ─── History ──────────────────────────────────────────────────────────────────
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# ─── Shell options ────────────────────────────────────────────────────────────
shopt -s checkwinsize

# ─── PATH & Homebrew ──────────────────────────────────────────────────────────
if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv bash)"
    export PATH="\
/opt/homebrew/bin:\
/opt/homebrew/sbin:\
$HOME/.config/scripts:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/bin:\
/usr/sbin:\
/bin:\
/sbin"
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
    export PATH="\
/home/linuxbrew/.linuxbrew/bin:\
/home/linuxbrew/.linuxbrew/sbin:\
$HOME/.dotnet/tools:\
$HOME/.config/scripts:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/bin:\
/usr/sbin:\
/bin:\
/sbin:\
/usr/games:\
/usr/lib/wsl/lib"
fi

# ─── Prompt ───────────────────────────────────────────────────────────────────
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
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n "$branch" ]] && git_part=" ${cyan}on${reset} ${bold}${branch}${reset}"

    PS1="${cyan}[${reset}\W${cyan}]${reset}${git_part} ${glyph_color}β${reset} "
}

PROMPT_COMMAND=__prompt

# ─── Colors & Aliases ─────────────────────────────────────────────────────────
if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -G'
    alias ll='ls -lahG'
else
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    alias ll='ls -lah --color=auto'
fi
alias grep='grep --color=auto'
alias vim=nvim
alias manh='f(){ help -m "$1" | bat -l man -p; }; f'

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# ─── Pager / Man ──────────────────────────────────────────────────────────────
export MANPAGER="sh -c 'col -bx | bat -l man -p --color=always'"
export MANROFFOPT="-c"

# ─── Completions ──────────────────────────────────────────────────────────────
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
