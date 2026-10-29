{config, ...}: let
  dir = "${config.home.homeDirectory}/.dotfiles/nix/modules/home/neru";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile."neru/config.toml".source = link "${dir}/config.toml";
}
