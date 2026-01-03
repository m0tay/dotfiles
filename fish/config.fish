fish_vi_key_bindings
function fish_mode_prompt
end
function fish_greeting
end
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_STATE_HOME ~/.local/state
set -g fish_autosuggestion_enabled 0
set -gx EDITOR nvim
set -gx READER sioyek
set -gx BROWSER safari

set -gx CTESP "$HOME/Documents/CTeSP"
set -gx BOOKS "$HOME/Library/Mobile Documents/iCloud~com~apple~iBooks/Documents"

fish_add_path "$HOME/bin"
fish_add_path "$HOME/.config/scripts"
fish_add_path "$HOME/.local/share/bob/nvim-bin"
fish_add_path "/opt/homebrew/opt/php@8.4/bin"
fish_add_path "/opt/homebrew/opt/php@8.4/sbin"

alias vim nvim
alias news newsraft

function safari
    if test (count $argv) -gt 0
        open -a "Safari" $argv
    else
        open -a "Safari"
    end
end

set -gx fish_browser safari

function nvm
    bass source (brew --prefix nvm)/nvm.sh ';' nvm $argv
end

function finder
  open .
end
