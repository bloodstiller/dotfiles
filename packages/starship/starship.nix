{ config, pkgs, lib, ... }:

let
  configFile = builtins.fromTOML (builtins.readFile ./laptopStarship.toml);
in
{
  programs.starship = {
    enable = true;
    
    settings = configFile;
    # Additional settings that apply to both configurations
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
