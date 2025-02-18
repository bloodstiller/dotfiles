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

    extraConfig = ''
      ${builtins.readFile ./config/hyprland.conf}
      source = ${./config/Monitors.conf}   
      source = ${./config/Autostart.conf}
      source = ${./config/Keybindings.conf}
      source = ${./config/Envs.conf}
      source = ${./config/laptopVariables.conf}
    '';
    
    settings = {
      monitor = ",preferred,auto,1";
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        no_focus_fallback = true;
      };
    };
  };

}
