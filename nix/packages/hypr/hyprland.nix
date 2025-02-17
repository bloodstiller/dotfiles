{ config, pkgs, ... }:

{
  # Enable Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    xwayland.enable = true;
    
    settings = {
      monitor = ",preferred,auto,1";
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        no_cursor_warps = true;
        no_focus_fallback = true;
      };
    };
  };

  # Create the hyprland configuration files
  home.file = {
    # Main config that sources other files
    ".config/hypr/hyprland.conf".source = ./config/hyprland.conf;
    
    # Individual configuration files
    ".config/hypr/Monitors.conf".source = ./config/Monitors.conf;
    ".config/hypr/Autostart.conf".source = ./config/Autostart.conf;
    ".config/hypr/Keybindings.conf".source = ./config/Keybindings.conf;
    ".config/hypr/Envs.conf".source = ./config/Envs.conf;
    ".config/hypr/Variables.conf".source = ./config/Variables.conf;
  };
}
