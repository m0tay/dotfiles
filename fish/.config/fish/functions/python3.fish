function python3
    set py (ls /opt/homebrew/bin/python3.* 2>/dev/null | grep -v '\-config$' | head -1)
    if test -n "$py"
        command $py $argv
    else
        command /usr/bin/python3 $argv
    end
end
