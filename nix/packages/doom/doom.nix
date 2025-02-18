{ config, pkgs, lib, ... }:

{
  # Enable Emacs with specific version
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
    ];
  };
}
