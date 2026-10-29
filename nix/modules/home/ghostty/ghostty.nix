{config, ...}: let
  dir = "${config.home.homeDirectory}/.dotfiles/nix/modules/home/ghostty";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile."ghostty/config".source = link "${dir}/config";
  xdg.configFile."ghostty/shaders".source = link "${dir}/shaders";
}
