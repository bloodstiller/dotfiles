{ pkgs, inputs, ... }:

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
      exec-once = ${inputs.hypridle.packages.${pkgs.system}.default}/bin/hypridle
      bind = $mainMod, L, exec, ${inputs.hyprlock.packages.${pkgs.system}.default}/bin/hyprlock
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

  # User-specific packages
  home.packages = with pkgs; [
    inputs.hyprlock.packages.${system}.default
    inputs.hypridle.packages.${system}.default
    kitty
    slurp
    scrot
    grim
    swappy
    wl-clipboard
    hyprshade
    pyprland
  ];
}
