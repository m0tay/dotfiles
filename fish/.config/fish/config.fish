function fish_greeting
end
set -g fish_autosuggestion_enabled 0
set -gx EDITOR nvim
set -gx READER sioyek
set -gx CTESP "$HOME/Documents/CTeSP"

if test (uname) = Darwin
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx MANROFFOPT "-c"
else
    set -gx MANPAGER "bat -l man -p"
end

fish_add_path "$HOME/bin"
fish_add_path /opt/homebrew/bin
fish_add_path /Library/Developer/CommandLineTools/usr/bin

alias vim nvim

function cppman
    set -lx PAGER "bat -l man -p"
    command cppman $argv
end

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

source ~/.orbstack/shell/init2.fish 2>/dev/null || :
direnv hook fish | source

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/douglaslobo/.lmstudio/bin
# End of LM Studio CLI section

