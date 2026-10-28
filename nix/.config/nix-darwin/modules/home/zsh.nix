{config, ...}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LESS = "-R -F -X -i -M";
    MANPAGER = "sh -c 'col -bx | bat -l man -p --color=always'";
    MANROFFOPT = "-c";
    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_ENV_HINTS = "1";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.config/scripts"
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.dotnet/tools"
    "${config.home.homeDirectory}/.lmstudio/bin"
    "/opt/homebrew/opt/uutils-coreutils/libexec/uubin"
    "/opt/homebrew/opt/uutils-findutils/libexec/uubin"
    "/opt/homebrew/opt/uutils-diffutils/libexec/uubin"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    autocd = true;

    history = {
      size = 50000;
      save = 50000;
      path = "${config.home.homeDirectory}/.local/state/zsh/history";
      share = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      extended = true;
    };

    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -lah --color=auto";
      grep = "grep --color=auto";
      vim = "nvim";
      k = "kubectl";
      ff = "fastfetch";
      neovide = "open -a Neovide";
      ndev = "nix develop -c $SHELL";
      nrs = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin";
    };

    initContent = ''
      [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"

      # Completions styling
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' use-cache yes
      local zsh_cache="''${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
      mkdir -p "$zsh_cache"
      zstyle ':completion:*' cache-path "$zsh_cache/zcompcache"
      zstyle ':completion:*:options' description yes
      zstyle ':completion:*:options' auto-description '%d'
      zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
      zstyle ':completion:*:messages'    format ' %F{purple}-- %d --%f'
      zstyle ':completion:*:warnings'    format ' %F{red}-- no matches found --%f'

      _cache_comp() {
        (( $+commands[$1] )) || return 0
        local f="$zsh_cache/comp-$1.zsh"
        [[ -s $f ]] || "$@" >| "$f" 2>/dev/null
        [[ -r $f ]] && source "$f"
      }
      _cache_comp ng completion script

      # Custom prompt
      _prompt_precmd() {
        local exit_status=$?
        local glyph="%F{magenta}"; (( exit_status )) && glyph="%F{red}"
        local branch git_part=""
        branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        [[ -n $branch ]] && git_part=" %F{cyan}on%f %B''${branch}%b"
        [[ -n $IN_NIX_SHELL ]] && git_part+=" %F{yellow}(nix)%f"
        PROMPT="%F{cyan}[%f%1~%F{cyan}]%f''${git_part} ''${glyph}β%f "
        printf '\e]7;file://%s%s\e\\' "$HOST" "$PWD"
      }
      autoload -Uz add-zsh-hook
      add-zsh-hook precmd _prompt_precmd

      # Utilities
      manh() { run-help "$1" 2>/dev/null | bat -l man -p; }

      if [[ -n $NVIM ]]; then
        nvim() {
          if (( $# == 0 )); then open -a Neovide
          else command nvim --server "$NVIM" --remote "$@"; fi
        }
      fi

      [[ -r ~/.orbstack/shell/init.zsh ]] && source ~/.orbstack/shell/init.zsh
    '';
  };
}
