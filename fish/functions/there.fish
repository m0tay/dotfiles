# Usage: there <path> <regex> [--do <command> [args...]]
# Finds entries in <path> matching <regex>, optionally runs a command on each match.

function there -d "retrieves what's there"
    set -l path $argv[1]
    set -l regex $argv[2]
    set -l do_cmd

    set -l i 3
    while test $i -le (count $argv)
        if test "$argv[$i]" = --do
            set do_cmd $argv[(math $i + 1)..-1]
            break
        end
        set i (math $i + 1)
    end

    if test -n "$regex" 
      set -f matches (command ls -A $path | grep -iE $regex)
    else
      set -f matches (command ls -A $path)
    end

    if test (count $matches) -eq 0
        echo "No matches found."
        return 1
    end

    if test (count $do_cmd) -gt 0
        for entry in $matches
            set -l full_path "$path/$entry"
            $do_cmd $full_path; or true
        end
    else
        printf '%s\n' $matches
    end
end
