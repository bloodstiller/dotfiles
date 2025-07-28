{ config, pkgs, ... }:

{
  programs = {
    kitty.enable = true;
    eza.enable = true;
    bat.enable = true;
  };
} 