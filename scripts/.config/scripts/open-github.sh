#!/usr/bin/env bash
[ -n "$TMUX" ] && cd "$(tmux display-message -p "#{pane_start_path}" 2>/dev/null)" 2>/dev/null

url=$(git remote get-url origin 2>/dev/null) || { echo "No remote found"; exit 0; }

[[ "$url" =~ ^git@github.com:(.*)\.git$ ]] && url="https://github.com/${BASH_REMATCH[1]}"

open "$url"
