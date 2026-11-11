{...}: {
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };

    taps = [
      "derailed/k9s"
      {
        name = "m0tay/miranda";
        clone_target = "git@github.com:m0tay/homebrew-miranda.git";
      }
      "nikitabobko/tap"
      "y3owk1n/tap"
    ];

    brews = [
      "uutils-findutils"
      "uutils-diffutils"
      "ollama"
      "iproute2mac"
    ];

    casks = [
      "aerospace"
      "anki"
      "bruno"
      "discord"
      "dotnet-sdk"
      "handy"
      "helium-browser"
      "jetbrains-toolbox"
      "kiwix"
      "localsend"
      "mongodb-compass"
      "neru"
      "notunes"
      "obsidian"
      "orbstack"
      "pgadmin4"
      "transmission"
      "whatsapp"
      "racket"
      "modrinth"
      "macusb"
      "vorssaint"
      "caskhub"
      "codex"
      "snapzy"
      "mach-local/validation/mach" # Verified local archive; public release pending GitHub authentication.

      "font-0xproto-nerd-font"
      "font-annotationmono-nerd-font" # TALVEZ: uma Nerd Font chega
    ];
  };
}
