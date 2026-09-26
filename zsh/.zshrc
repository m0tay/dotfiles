# ~/.zshrc

# ─── History ──────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt append_history
setopt hist_ignore_space
setopt hist_ignore_dups

# ─── PATH & Homebrew ──────────────────────────────────────────────────────────
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [[ "$(uname)" == "Darwin" ]]; then
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
else
    export DOTNET_ROOT=/home/linuxbrew/.linuxbrew/Cellar/dotnet@8/8.0.124/libexec
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/opt/dotnet@8/bin"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
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

# ─── Completions ──────────────────────────────────────────────────────────────
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# ─── Prompt ───────────────────────────────────────────────────────────────────
setopt prompt_subst
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

# ─── Colors & Aliases ─────────────────────────────────────────────────────────
if [ -x /opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors ]; then
    test -r ~/.dircolors && eval "$(/opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors -b ~/.dircolors)" || eval "$(/opt/homebrew/opt/uutils-coreutils/libexec/uubin/dircolors -b)"
fi
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias vim=nvim

manh() {
    run-help "$1" 2>/dev/null | bat -l man -p
}


# ─── Pager / Man ──────────────────────────────────────────────────────────────
export MANPAGER="sh -c 'col -bx | bat -l man -p --color=always'"
export MANROFFOPT="-c"

# Open files in parent Neovim instance when inside a Neovim terminal
if [[ -n "$NVIM" ]]; then
    nvim() {
        if [[ $# -eq 0 ]]; then
            open -a Neovide
        else
            command nvim --server "$NVIM" --remote "$@"
        fi
    }
fi
alias neovide="/Applications/Neovide.app/Contents/MacOS/neovide &>/dev/null &"
alias neovide="open -a Neovide"
export KUBECONFIG="$HOME/.kube/config"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/douglaslobo/.lmstudio/bin"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/douglaslobo/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
