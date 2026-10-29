{self, ...}: {
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.reattach = true;

  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
    };
  };

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.enable = false;
  system.primaryUser = "douglaslobo";
  environment.pathsToLink = ["/share/zsh-syntax-highlighting"];
}
