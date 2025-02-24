{ config, pkgs, ... }:

{
  programs = {
    wofi.enable = true;
    waybar.enable = true;
  };
} 