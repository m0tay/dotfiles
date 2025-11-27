setopt append_history inc_append_history share_history
setopt auto_menu menu_complete
setopt autocd
setopt auto_param_slash
setopt no_case_glob no_case_match
setopt globdots extended_glob interactive_comments
unsetopt prompt_sp

bindkey -e  # emacs keybindings

unset ZLE_KEYMAP_SELECT
zle -A .self-insert zle-keymap-select 2>/dev/null

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
