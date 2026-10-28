{config, ...}: let
  dir = "${config.home.homeDirectory}/.dotfiles/nix/.config/nix-darwin/modules/home/aerospace";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile."aerospace/aerospace.toml".source = link "${dir}/aerospace.toml";
}
