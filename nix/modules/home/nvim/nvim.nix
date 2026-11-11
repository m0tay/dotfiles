{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;
    package = pkgs.neovim-unwrapped;
  };
}
