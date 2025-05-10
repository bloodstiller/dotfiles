{ config, pkgs, lib, ... }:

{
  home = {
    username = "martin";
    homeDirectory = "/home/martin";

    sessionVariables = {
      EDITOR = "${lib.getExe pkgs.emacs}";
      BROWSER = "${lib.getExe pkgs.firefox}";
      TERMINAL = "${lib.getExe pkgs.alacritty}";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/xhtml+xml" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";
    };
  };
}
