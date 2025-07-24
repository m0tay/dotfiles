#!/bin/bash

SESSION="m0m0"

if [ -n "$TMUX" ]; then
    if tmux has-session -t "$SESSION" 2>/dev/null; then
        tmux switch-client -t "$SESSION" 2>/dev/null || tmux attach-session -t "$SESSION"
    else
        tmux new-session -d -s "$SESSION"
        tmux switch-client -t "$SESSION" 2>/dev/null || tmux attach-session -t "$SESSION"
    fi
else
    tmux new-session -A -s "$SESSION"
fi

