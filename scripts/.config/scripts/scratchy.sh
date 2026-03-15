#!/usr/bin/env bash
titles=(
  "I'm feeling lucky"
  "I'm thinking about..."
  "Let's brainstorm"
  "Quick thoughts"
  "Mind dump"
  "Brainwave incoming"
  "Noteworthy ideas"
  "Scratch pad"
  "Random musings"
  "Deep thoughts"
  "Brain dump time"
  "Brilliant ideas"
)
title="${titles[$RANDOM % ${#titles[@]}]}"
tmux display-popup -E -w 70% -h 90% -T "$title" "vim ~/Documents/geschaeftsmann/scratch-notes/$(date +%Y-%m-%d).typ"
