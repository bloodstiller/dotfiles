{ config, pkgs, inputs, ... }:

let cursor = pkgs.callPackage ../cursor/cursor.nix { };

in {
  imports = [
    ./modules/base.nix # Basic home-manager configuration
    ./modules/cli-tools.nix # CLI tools like eza, bat
    ./modules/git.nix # Git configuration
    ./modules/theme.nix # Theme, cursor, and GTK settings

    # Your existing imports can be moved to programs.nix
    (import ../packages/packages.nix { inherit pkgs cursor; })
    ../alacritty/alacritty.nix
    ../atuin/atuin.nix
    ../doom/doom.nix
    ../dunst/dunst.nix
    ../foot/foot.nix
    ../hypr/hyprland.nix
    ../kitty/kitty.nix
    ../Pia/pia.nix
    ../scripts/scripts.nix
    ../sops/sops.nix
    ../tmux/tmux.nix
    ../waybar/waybar.nix
    ../wofi/wofi.nix
    ../yazi/yazi.nix
    ../zsh/zsh.nix
  ];

  # Set Home Manager State Version
  home.stateVersion = "25.05";
}
