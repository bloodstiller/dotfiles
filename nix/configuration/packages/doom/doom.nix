{ config, pkgs, ... }:

{
  # Enable Emacs with specific version
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };

  # Create the doom configuration files link
  home.file = {
    ".config/doom" = {
      source = ./config;  # Points to your doom config directory
      recursive = true;     # Include all subdirectories
    };
  };
}
