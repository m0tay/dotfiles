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

fish_add_path "$HOME/bin"
fish_add_path "$HOME/.config/scripts"
fish_add_path "$HOME/.local/share/bob/nvim-bin"
fish_add_path "/opt/homebrew/opt/php@8.4/bin"
fish_add_path "/opt/homebrew/opt/php@8.4/sbin"

alias vim nvim
alias news newsraft

function finder
  open .
end

function se --description "Fuzzy search"
  ls | fzf --reverse --margin=20% --query="$argv[1]"
end

function lf --description "List file"
  yazi
end
