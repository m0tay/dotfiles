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
    printf '\e]7;file://%s%s\e\\' "$HOSTNAME" "$PWD"
}

PROMPT_COMMAND=__prompt

# ─── Colors & Aliases ─────────────────────────────────────────────────────────
if [ -x /opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors ]; then
    test -r ~/.dircolors && eval "$(/opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors -b ~/.dircolors)" || eval "$(/opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors -b)"
fi
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
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

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/douglaslobo/.lmstudio/bin"
# End of LM Studio CLI section

# Open files in parent Neovim instance when inside a Neovim terminal
if [[ -n "$NVIM" ]]; then
    nvim() {
        if [[ $# -eq 0 ]]; then
            # No args: open a new Neovide window instead of erroring
            open -a Neovide
        else
            command nvim --server "$NVIM" --remote "$@"
        fi
    }
fi
alias neovide="/Applications/Neovide.app/Contents/MacOS/neovide &>/dev/null &"
alias neovide="open -a Neovide"
export KUBECONFIG="$HOME/.kube/config"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/douglaslobo/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

