{ config, pkgs, ... }:

{
  home = {
    username = "martin";
    homeDirectory = "/home/martin";
    
    sessionVariables = {
      EDITOR = "vim";
    };
  };
} 