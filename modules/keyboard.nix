{ config, pkgs, ... }:

{
  # Configure console keymap
  console = {
    useXkbConfig = true; # This will use the X11 keyboard configuration
  };

  # Keyboard layout configuration
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
    options = "caps:escape";
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ]; # Apply to all keyboards
      settings = {
        main = {
          "meta+c" = "C-c"; # Map Cmd+C to Ctrl+C
          "meta+v" = "C-v"; # Map Cmd+V to Ctrl+V
        };
      };
    };
  };

}

