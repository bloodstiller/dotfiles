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

    settings = {
      global = {
        origin = "top-right";
        offset = "30x30";
        alignment = "center";
        width = "(0, 300)";
        notification_limit = 5;
      };
    };
  };
}
