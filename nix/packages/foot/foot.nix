{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;

  };
  #home.file = { ".config/foot/foot.ini" = { source = ./foot.ini; }; };
}
