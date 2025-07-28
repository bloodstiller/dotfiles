{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [ 
        nerd-fonts.jetbrains-mono 
        nerd-fonts.iosevka ];
  };
}
