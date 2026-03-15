function fish_prompt
    set_color red
    echo -n '['
    set_color magenta
    echo -n (prompt_pwd)
    set_color red
    echo -n '] '
    set_color cyan
    echo -n 'λ '
    set_color normal
end
