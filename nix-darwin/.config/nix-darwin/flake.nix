{
  description = "trying out nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
  }: let
    configuration = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        kubectl
        bat
        fastfetch
        direnv
        neovim

        uutils-coreutils-noprefix
        fzf
        fd
        ripgrep
        tmux
        htop
        curl
        wget
        rename
        stow
        yq-go
        just
        tealdeer
        yazi
        micro
        zsh-syntax-highlighting
        lazygit
        gh
        gnupg
        pinentry_mac
        pandoc
        typst
        newsraft
        nixd
        alejandra

        nmap
        ipcalc
        wireguard-tools
        httpie
        opentofu
        awscli2

        go
        rustup
        uv
        gnumake
        tree-sitter
        harper
        neovide
      ];

      homebrew = {
        enable = true;

        onActivation = {
          autoUpdate = false;
          upgrade = false;
          cleanup = "uninstall";
        };

        taps = [
          "derailed/k9s"
          {
            name = "m0tay/miranda";
            clone_target = "git@github.com:m0tay/homebrew-miranda.git";
          }
          "nikitabobko/tap"
          "y3owk1n/tap"
        ];

        brews = [
          "uutils-findutils"
          "uutils-diffutils"
          "ollama"
          "iproute2mac"
        ];

        casks = [
          "aerospace"
          "anki"
          "bruno"
          "discord"
          "dotnet-sdk"
          "ghostty"
          "handy"
          "helium-browser"
          "jetbrains-toolbox"
          "kiwix"
          "localsend"
          "mongodb-compass"
          "neru"
          "notunes"
          "obsidian"
          "orbstack"
          "pgadmin4"
          "transmission"
          "whatsapp"
          "racket"

          "font-0xproto-nerd-font"
          "font-annotationmono-nerd-font" # TALVEZ: uma Nerd Font chega
        ];
      };

      security.pam.services.sudo_local.touchIdAuth = true;
      security.pam.services.sudo_local.reattach = true;

      system.defaults = {
        dock = {
          autohide = true;
          show-recents = false;
          mru-spaces = false;
        };

        finder = {
          AppleShowAllExtensions = true;
          FXPreferredViewStyle = "Nlsv";
          ShowPathbar = true;
        };
      };

      system.configurationRevision =
        self.rev or self.dirtyRev or null;

      system.stateVersion = 6;
      nixpkgs.hostPlatform = "aarch64-darwin";
      nix.enable = false;
      system.primaryUser = "douglaslobo";
      environment.pathsToLink = ["/share/zsh-syntax-highlighting"];
    };
  in {
    darwinConfigurations."Douglass-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          users.users.douglaslobo.home = "/Users/douglaslobo";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            users.douglaslobo = {config, ...}: {
              home.stateVersion = "26.05";
            };
          };
        }
      ];
    };
  };
}
