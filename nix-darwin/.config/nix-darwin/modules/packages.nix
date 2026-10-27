{pkgs, ...}: {
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
}
