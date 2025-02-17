{ config, pkgs, ... }:

{
  # Install any dependencies your scripts might need
  home.packages = with pkgs; [
    # Add any packages your scripts depend on
    # For example:
    # jq
    # python3
    # bash
  ];

  # Create the scripts directory and make scripts executable
  home.file = {
    ".config/scripts" = {
      source = ./scripts;  # Points to your scripts directory
      executable = true;   # Makes all scripts executable
      recursive = true;    # Include all subdirectories
    };
  };
}
