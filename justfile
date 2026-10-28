default: switch

# Rebuild and switch darwin system configuration
switch:
    sudo darwin-rebuild switch --flake ~/.dotfiles/nix/.config/nix-darwin

# Check flake syntax and evaluate configuration
check:
    nix flake check ~/.dotfiles/nix/.config/nix-darwin

# Update all flake inputs
update:
    nix flake update --flake ~/.dotfiles/nix/.config/nix-darwin

# Garbage collect old generations
gc:
    nix-collect-garbage -d
