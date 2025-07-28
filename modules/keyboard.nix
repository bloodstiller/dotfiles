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
}