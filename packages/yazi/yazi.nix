{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/yazi/yazi.toml".text = ''
    [manager]
    show_hidden = true
    sort_by = "alphabetical"
    show_symlink = true
  '';
}
