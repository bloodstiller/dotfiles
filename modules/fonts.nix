{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      ibm-plex
      source-code-pro
      nerd-fonts.commit-mono
    ];
  };
}
