{config, ...}: let
  dir = "${config.home.homeDirectory}/.dotfiles/nix/modules/home/neovide";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile."neovide/config.toml".source = link "${dir}/config.toml";
}
