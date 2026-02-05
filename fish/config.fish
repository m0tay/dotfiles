fish_vi_key_bindings
function fish_mode_prompt
end
function fish_greeting
end
set -g fish_autosuggestion_enabled 0
set -gx EDITOR nvim
set -gx READER sioyek

set -gx CTESP "$HOME/Documents/CTeSP"
set -gx BOOKS "$HOME/Library/Mobile Documents/iCloud~com~apple~iBooks/Documents"
set -gx MONO_GAC_PREFIX "/opt/homebrew"

fish_add_path "$HOME/bin"
fish_add_path "$HOME/.config/scripts"
fish_add_path "$HOME/.local/share/bob/nvim-bin"
fish_add_path "$HOME/.dotnet/tools"
fish_add_path "$HOME/omnisharp"

alias vim nvim
alias news newsraft

function finder
    open .
end

function se --description "Fuzzy search"
    ls | fzf --reverse --margin=20% --query="$argv[1]"
end

function seb --description "Fuzzy search books"
    ls "$BOOKS" | fzf --reverse --margin=20% | xargs -I {} open "$BOOKS/{}"
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function mira
  rlwrap -- mira
end

