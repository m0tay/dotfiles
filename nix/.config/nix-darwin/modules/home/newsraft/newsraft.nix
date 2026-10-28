{config, ...}: let
  dir = "${config.home.homeDirectory}/.dotfiles/nix/.config/nix-darwin/modules/home/newsraft";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile."newsraft/config".source = link "${dir}/config";
  xdg.configFile."newsraft/feeds".source = link "${dir}/feeds";
}
