{ config, lib, pkgs, ... }:

{
  # Enable polkit
  security.polkit.enable = true;
  # Install polkit-lxqt (auth agent required for keyring + system prompts)
  environment.systemPackages = with pkgs; [ lxqt.lxqt-policykit ];
}
