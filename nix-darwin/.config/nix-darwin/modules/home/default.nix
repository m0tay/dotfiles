{
  lib,
  nixvim,
  ...
}: {
  users.users.douglaslobo.home = "/Users/douglaslobo";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    users.douglaslobo = {
      xdg.enable = true;
      imports =
        [
          nixvim.homeModules.nixvim
        ]
        ++ lib.fileset.toList (
          lib.fileset.fileFilter (file: file.hasExt "nix" && file.name != "default.nix") ./.
        );
      home.stateVersion = "26.05";
    };
  };
}
