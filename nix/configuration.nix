# Edit this configuration file to define what should be installed onGV
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/appimages.nix
    ./modules/bluetooth.nix
    ./modules/bootloader.nix
    ./modules/de.nix
    ./modules/fonts.nix
    ./modules/keyboard.nix
    ./modules/locale.nix
    ./modules/network.nix
    ./modules/nfs.nix
    ./modules/nix.nix
    ./modules/nvidia.nix
    ./modules/pkgs.nix
    ./modules/security.nix
    ./modules/sound.nix
    ./modules/tailscale.nix
    ./modules/users.nix
    ./modules/virtualization.nix
    ./modules/x11.nix
  ];


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.05"; # Did you read the comment?

}
