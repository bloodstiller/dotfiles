{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    
    # Install additional packages needed for your scripts
    package = pkgs.wofi.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [
        pkgs.jq    # For sway-select-window.sh
        pkgs.python3  # For windows.py
      ];
    });
  };

  # Create the wofi configuration files
  home.file = {
    ".config/wofi/config".source = ./config/config;
    ".config/wofi/config.power".source = ./config/config.power;
    ".config/wofi/config.screenshot".source = ./config/config.screenshot;
    ".config/wofi/style.css".source = ./config/style.css;
    ".config/wofi/style.widgets.css".source = ./config/style.widgets.css;
    
    # Make scripts executable
    ".config/wofi/sway-select-window.sh" = {
      source = ./config/sway-select-window.sh;
      executable = true;
    };
    
    ".config/wofi/windows.py" = {
      source = ./config/windows.py;
      executable = true;
    };
  };
}
