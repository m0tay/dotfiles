{config, ...}: let
  dir = "${config.home.homeDirectory}/.dotfiles/nix-darwin/.config/nix-darwin/modules/home/neovide";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile."neovide/config.toml".source = link "${dir}/config.toml";
}
