{ config, pkgs, lib, ... }:

let
  hostname = builtins.readFile "/etc/hostname";
  isZeus = lib.strings.hasInfix "zeus" hostname;
in
{
  programs.starship = {
    enable = true;
    
    # Choose configuration file based on hostname
    settings = if isZeus then
      builtins.fromTOML (builtins.readFile ./laptopStarship.toml)
    else
      builtins.fromTOML (builtins.readFile ./starship.toml);

    # Additional settings that apply to both configurations
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
