default: switch

switch:
    sudo darwin-rebuild switch --flake ~/.dotfiles/nix

check:
    nix flake check ~/.dotfiles/nix

update:
    nix flake update --flake ~/.dotfiles/nix

gc:
    nix-collect-garbage -d
