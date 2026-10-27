{
  description = "trying out nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nix-darwin,
    home-manager,
    ...
  }: {
    darwinConfigurations."Douglass-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit self;};
      modules = [
        ./modules/system.nix
        ./modules/packages.nix
        ./modules/homebrew.nix
        home-manager.darwinModules.home-manager
        ./modules/home
      ];
    };
  };
}
