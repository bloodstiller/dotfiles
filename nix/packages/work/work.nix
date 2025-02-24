{ pkgs, ... }:

{
  home.packages = with pkgs; [
    slack
    google-chrome
    _1password-cli
    _1password-gui

  ];
}