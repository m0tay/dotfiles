set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_STATE_HOME ~/.local/state

set -g fish_autosuggestion_enabled 0
set -gx PAGER "less"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path /opt/homebrew/bin

function ff
    fastfetch
end

function ccat
    highlight --out-format=ansi $argv
end
