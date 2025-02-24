{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    
    settings = {
      sync_address = "https://api.atuin.sh";
      sync_frequency = "5m";
    };
  };
} 