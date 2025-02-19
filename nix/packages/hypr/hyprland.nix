{ config, pkgs, ... }:

let
  hyprlock = pkgs.hyprlock;
  hypridle = pkgs.hypridle;
in
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

      # Add hyprlock and hypridle configurations directly
      exec-once = ${hypridle}/bin/hypridle
      bind = $mainMod, L, exec, ${hyprlock}/bin/hyprlock
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

  # Add script files
  # Keep actual congfigs seperated from scripts as above
  home.file = {
    ".config/hypr/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };
  };

  # Make the packages available
  home.packages = with pkgs; [
    hyprlock
    hypridle
  ];

}