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
    };

    initContent = ''
      [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"
      [[ -r ~/.orbstack/shell/init.zsh ]] && source ~/.orbstack/shell/init.zsh
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$nix_shell$sudo$character";

      directory = {
        format = "[$path]($style) ";
        style = "cyan";
        truncation_length = 1;
        truncate_to_repo = false;
      };

      git_branch = {
        format = "on [$branch]($style) ";
        style = "bold cyan";
      };

      nix_shell = {
        format = "[(nix)]($style) ";
        style = "bold yellow";
      };

      character = {
        success_symbol = "[λ](bold magenta) ";
        error_symbol = "[λ](bold red) ";
      };

      sudo = {
        disabled = false;
        symbol = "# ";
        style = "bold red";
        format = "[$symbol]($style)";
      };
    };
  };
}
