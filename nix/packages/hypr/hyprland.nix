{ pkgs, inputs, ... }:

{
  # Enable Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = { enable = true; };
    xwayland.enable = true;

    # Use the correct package from the flake
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    extraConfig = ''
      ${builtins.readFile ./config/hyprland.conf}
      source = ${./config/Monitors.conf}   
      source = ${./config/Autostart.conf}
      source = ${./config/Keybindings.conf}
      source = ${./config/Envs.conf}
      source = ${./config/laptopVariables.conf}

      # Hypridle and Hyprlock configuration
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

  # Optional but recommended: add electron apps hint for Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # Add script files
  # Keep actual congfigs seperated from scripts as above
  home.file = {
    ".config/hypr/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };
  };

  # Add hyprlock and hypridle config files
  xdg.configFile = {
    "hypr/hyprlock.conf".source = ./config/hyprlock.conf;
    "hypr/hypridle.conf".source = ./config/hypridle.conf;
    "hypr/pyprland.toml".source = ./config/pyprland.toml;
  };

  # User-specific packages
  home.packages = with pkgs; [
    inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.default
    kitty
    slurp
    scrot
    grim
    swappy
    wl-clipboard
    hyprshade
    pyprland
    nwg-displays
  ];
}
