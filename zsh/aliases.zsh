alias vim=nvim
alias ff=fastfetch
alias myip='dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed "s/\"//g"'
alias ccat='highlight --out-format=ansi'

alias rm="rm -I"       
alias cp="cp -i"       
alias mv="mv -i"       

alias ls='ls -CtUApG'         
alias ll='ls -lahG'      

alias finder='open .'
alias safari='open -a "Safari"'
alias news=$NEWS_READER

alias sed='sed -E'
alias grep='grep --color'
alias mkdir='mkdir -p'
alias cltx='find . -type f | grep -v "\.tex" | grep -v "\.pdf" | xargs rm' # clean tex, log, aux and other files to generate pdf from LaTeX
# alias play='fzf | xargs vlc'
alias ddoc='open https://devdocs.io'
alias searchbook='ls "$BOOKS" |  fzf | xargs -I {} open "$BOOKS/{}"'
alias tree='tree -F --dirsfirst'
alias t1='tree -L1'
alias t2='tree -L2'

cheat() {
  local url="cheat.sh"

  case "$1" in
    -l)
      [ -z "$2" ] && echo "Usage: cheat -l <sheet>" >&2 && return 1
      url="$url/$2/:learn"
      ;;
    -h)
      echo "Usage: cheat [-l] <sheet> [query]"
      echo "  -l <sheet>     Learn mode"
      echo "  <sheet>        Show cheatsheet"
      echo "  <sheet> <q>    Query in sheet"
      return 0
      ;;
    -H)
      curl cheat.sh/
      return 0
      ;;
    -*)
      echo "Unknown flag: $1" >&2
      return 1
      ;;
    "")
      echo "Usage: cheat [-l] <sheet> [query]" >&2
      return 1
      ;;
    *)
      url="$url/$1"
      [ -n "$2" ] && url="$url/$2"
      ;;
  esac

  curl -sS "$url" | less
}

html2pdf() {
  local url="$1"
  local name="$2"

  if [[ -z "$url" || -z "$name" ]]; then
    echo "Usage: html2pdf <url> <output-name>" >&2
    return 1
  fi

  curl -sL "$url" | pandoc -f html -o "${name}.pdf"
}

play () {
  set +m
  mpv --no-terminal \
    --ytdl-format="bestvideo[ext=mp4][height<=1440]+bestaudio[ext=m4a]/best[ext=mp4][height<=1440]" \
    --cache=yes \
    --cache-secs=60 \
    --demuxer-max-bytes=50000000 \
    --demuxer-max-back-bytes=20000000 \
    $1 > /dev/null & \
    disown
  set -m
}

alias retro='~/.config/scripts/retro'

# retro () {
#     local config="$HOME/.config/ghostty/config"
#     local from="# custom-shader"
# 		local to="custom-shader"
#
#     if [[ ! -f $config ]]; then
#         echo 'Ghostty config not found at $config'
#         return 1
#     fi
#
# 		if [[ -n $(grep -E "^${from}" $config) ]]; then
# 			sed -i "" -e "s/^${from}/${to}/" $config
# 		elif [[ -n $(grep -E "^${to}" $config) ]]; then
# 			sed -i "" -e "s/^${to}/${from}/" $config	
# 		else
# 			echo 'ahh'
# 			return 1
# 		fi
# }

lfcd () {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}

mkcd () {
  mkdir -p "$1" && cd "$1"
}
