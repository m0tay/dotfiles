alias nv=nvim
alias ff=fastfetch
alias myip='dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed "s/\"//g"'
alias ccat='highlight --out-format=ansi'

alias rm="rm -I"       
alias cp="cp -i"       
alias mv="mv -i"       

alias ls='ls -C -t -U -A -p -G'         
alias ll='ls -lahG'      

alias finder='open .'
alias safari='open -a "Safari"'
alias news=$NEWS_READER

alias sed='sed -E'
alias grep='grep --color'
alias mkdir='mkdir -p'
alias cltx='find . -type f | grep -v "\.tex" | grep -v "\.pdf" | xargs rm' # clean tex, log, aux and other files to generate pdf from LaTeX
alias play='fzf | xargs vlc'

retro() {
    local config="$HOME/.config/ghostty/config"
    local shader_line="custom-shader"

    if [[ ! -f $config ]]; then
        echo 'Ghostty config not found at $config'
        return 1
    fi

		if [[ -n $(grep -E "^# ${shader_line}" $config) ]]; then
			sed -i "" -e "s/^# ${shader_line}/${shader_line}/" $config
		elif [[ -n $(grep -E "^${shader_line}" $config) ]]; then
			sed -i "" -e "s/^${shader_line}/# ${shader_line}/" $config	
		else
			echo 'ahh'
			return 1
		fi
}

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
