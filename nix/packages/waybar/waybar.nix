{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    # Install additional packages needed for scripts and enable wireplumber support
    package = (pkgs.waybar.override {
      wireplumberSupport = true;
    }).overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
        pkgs.python3 # For mediaplayer.py
        pkgs.playerctl # For media controls
        pkgs.bash # For shell scripts
        pkgs.grim # For screenshots (referenced in keyhint.sh)
        pkgs.jq # For weather.sh
        pkgs.curl # For weather.sh
        pkgs.systemd # For power-menu.sh
        pkgs.yad # For keyhint.sh
      ];
    });
  };

  # Create the waybar configuration files
  home.file = {
    # Main config files
    ".config/waybar/config".source = ./config/config;

    # Style files
    ".config/waybar/style.css".source = ./config/style.css;
    ".config/waybar/style2.css".source = ./config/style2.css;

    # Shell scripts
    ".config/waybar/scripts" = {
      source = ./config/scripts;
      recursive = true;
      executable = true;
    };
  };
}
