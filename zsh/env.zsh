eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR=nvim
export NVIM_APPNAME=nvim/zu-schlafen
export READER=sioyek
export NEWS_READER=newsraft
export BROWSER=safari
export BROWSER2=zen
# export TERM=xterm-ghostty
export MANPAGER="less -R --use-color"
export LESS="R --use-color"
export LC_ALL="en_US.UTF-8"

export CTESP="$HOME/Documents/CTeSP"

export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.gem/ruby/3.4.0/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export PATH="$HOME/.local/share/mise/installs/ubi-adwinying-php/8.4.10/php:$PATH"
export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
# export PATH="$HOME/.config/shell/scripts:$PATH"
export PATH="/opt/homebrew/share/flutter/bin:$PATH"
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
export PATH="$HOME/.config/sioyek/venv/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
