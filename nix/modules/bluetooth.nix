{ pkgs, ... }:

{
  # Enable bluetooth and blueman
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Optional: automatically power-on Bluetooth at boot
  };

  # Blueman for bluetooth management
  services.blueman.enable = true;

}
