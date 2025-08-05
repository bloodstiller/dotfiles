{ config, pkgs, inputs, ... }:

let cursor = pkgs.callPackage ../cursor/cursor.nix { };
in {
  imports = [
    ./modules/base.nix # Basic home-manager configuration
    ./modules/cli-tools.nix # CLI tools like eza, bat
    ./modules/git.nix # Git configuration
    ./modules/theme.nix # Theme, cursor, and GTK settings

    # inputs has to be passed to allow unstable packages from packages to be passed
    (import ../packages/packages.nix { inherit pkgs cursor inputs; })
    ../alacritty/alacritty.nix
    ../atuin/atuin.nix
    ../doom/doom.nix
    ../dunst/dunst.nix
    ../hypr/hyprland.nix
    ../kitty/kitty.nix
    ../nvim/nvim.nix
    ../Pia/pia.nix
    ../scripts/scripts.nix
    ../sops/sops.nix
    ../tmux/tmux.nix
    ../waybar/waybar.nix
    ../wofi/wofi.nix
    ../zsh/zsh.nix
  ];

  # Set Home Manager State Version
  home.stateVersion = "25.05";
}
