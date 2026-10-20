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
          # Já tinhas
          vim
          kubectl
          bat
          fastfetch
          direnv
          neovim

          # Shell e utilitários
          uutils-coreutils-noprefix
          fzf
          fd
          ripgrep
          tmux
          htop
          btop
          curl
          wget
          parallel
          rlwrap
          rename
          entr
          stow
          yq-go
          just
          tealdeer
          yazi
          nnn
          micro
          skim
          sc-im
          nushell
          zsh-syntax-highlighting
          lazygit
          gh
          gnupg
          pinentry_mac
          qrencode
          pandoc
          typst
          imagemagick
          newsraft
          yewtube

          # Rede e operações
          nmap
          ipcalc
          tcptraceroute
          wireguard-tools
          httpie
          hey
          ansible
          opentofu
          awscli2
          kind
          ctop
          reg

          # Desenvolvimento
          go
          zig
          rustup
          uv
          pnpm
          ruff
          gnumake
          cmake
          meson
          xmake
          nasm
          re2c
          bison
          automake
          autoconf-archive
          ccache
          clang-tools
          tree-sitter
          luarocks
          lua5_4
          ghc
          gradle
          maven
          jdk21
          esptool
          raylib
          mongosh
          codeberg-cli
          harper
          fish-lsp
        ];

        homebrew = {
          enable = true;

          onActivation = {
            autoUpdate = false;
            upgrade = false;
            cleanup = "none";
          };

          taps = [
            "d12frosted/emacs-plus"
            "derailed/k9s"
            "docker/tap"
            "hashicorp/tap"
            "homebrew-zathura/zathura"
            "jesseduffield/lazydocker"
            {
              name = "m0tay/miranda";
              clone_target = "git@github.com:m0tay/homebrew-miranda.git";
            }
            "nikitabobko/tap"
            "oven-sh/bun"
            "spring-io/tap"
            "y3owk1n/tap"
          ];

          brews = [
            "uutils-coreutils"
            "uutils-findutils"
            "uutils-diffutils"
            "ollama"
            "postgresql@18"
            "mpv"
            "iproute2mac"
            "bbrew"
            "herdr"
          ];

          casks = [
            "aerospace"
            "anki"
            "antigravity-cli"
            "balenaetcher"
            "bettercapture"
            "brave-browser"
            "bruno"
            "dash@6"
            "discord"
            "dotnet-sdk"
            "firefox"
            "ghostty"
            "handy"
            "helium-browser"
            "intellij-idea"
            "jetbrains-toolbox"
            "kiwix"
            "localsend"
            "mongodb-compass"
            "neovide-app"
            "neru"
            "notunes"
            "obsidian"
            "orbstack"
            "pgadmin4"
            "sioyek"
            "transmission"
            "visual-studio-code"
            "vlc"
            "vscodium"
            "whatsapp"
            "zotero"

            # Fontes
            "font-0xproto-nerd-font"
            "font-annotationmono-nerd-font"
            "font-libertinus-math"
            "font-linux-libertine"
            "font-new-computer-modern"
            "font-ubuntu"
            "font-vollkorn"
            "font-vollkorn-sc"
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
