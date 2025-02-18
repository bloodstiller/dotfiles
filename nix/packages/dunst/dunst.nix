{ config, pkgs, ... }:

{
  # Enable Dunst service
  services.dunst = {
    enable = true;
    
    # Only start Dunst if we're in a Wayland session
    waylandDisplay = "wayland-1";
    
    # Install additional packages if needed
    package = pkgs.dunst;
    configFile = ./dunstrc;
  };
}
