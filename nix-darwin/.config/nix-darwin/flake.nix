{
  description = "Douglas's nix-darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { pkgs, ... }: {
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
          rename                      # TALVEZ: nicho
          stow
          yq-go
          just
          tealdeer
          yazi
          micro                       # REMOVER: tens neovim
          zsh-syntax-highlighting
          lazygit
          gh
          gnupg
          pinentry_mac
          pandoc                      # TALVEZ: só se usares
          typst                       # TALVEZ: só se usares
          newsraft                    # TALVEZ: só se leres RSS

          nmap
          ipcalc
          wireguard-tools
          httpie                      # REMOVER: curl chega
          opentofu                    # TALVEZ: só se usas
          awscli2                     # TALVEZ: só se usas AWS

          go
          rustup
          uv
          gnumake
          tree-sitter
          harper                      # TALVEZ: só se usas no nvim
        ];

        homebrew = {
          enable = true;

          onActivation = {
            autoUpdate = false;
            upgrade = false;
            cleanup = "none";
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
            "postgresql@18"           # TALVEZ: o teu trabalho é SQL Server
            "mpv"
            "iproute2mac"
          ];

          casks = [
            "aerospace"
            "anki"
            "bruno"                   # TALVEZ: só se usas
            "discord"
            "dotnet-sdk"
            "ghostty"
            "handy"                   # TALVEZ: testado e esquecido?
            "helium-browser"          # TALVEZ: um browser chega
            "jetbrains-toolbox"       # TALVEZ: duplica intellij-idea
            "kiwix"                   # TALVEZ: uso raro
            "localsend"
            "mongodb-compass"         # TALVEZ: o teu trabalho é SQL Server
            "neovide-app"
            "neru"                    # TALVEZ: testado e esquecido?
            "notunes"                 # TALVEZ: uso raro
            "obsidian"
            "orbstack"
            "pgadmin4"                # TALVEZ: só se usas Postgres
            "sioyek"
            "transmission"            # TALVEZ: uso raro
            "vlc"                     # TALVEZ: tens mpv
            "whatsapp"

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
        environment.pathsToLink = [ "/share/zsh-syntax-highlighting" ];
      };
    in
    {
      darwinConfigurations."Douglass-MacBook-Pro" =
        nix-darwin.lib.darwinSystem {
          modules = [ configuration ];
        };
    };
}
