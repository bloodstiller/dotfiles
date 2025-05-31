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
      # Web browsers
      "application/xhtml+xml" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";

      # File manager
      "inode/directory" = "thunar.desktop";

      # Text files
      "text/plain" = "emacs.desktop";
      "text/x-readme" = "emacs.desktop";
      "text/x-changelog" = "emacs.desktop";

      # Images
      "image/jpeg" = "firefox.desktop";
      "image/png" = "firefox.desktop";
      "image/gif" = "firefox.desktop";
      "image/webp" = "firefox.desktop";

      # Media
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "audio/mpeg" = "mpv.desktop";
      "audio/mp4" = "mpv.desktop";

      # Archive files
      "application/zip" = "org.gnome.FileRoller.desktop";
      "application/x-rar" = "org.gnome.FileRoller.desktop";
      "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
    };

    associations.added = {
      # Add additional associations without overriding defaults
      "application/pdf" = [ "firefox.desktop" ];
      "text/plain" = [ "emacs.desktop" ];
    };
  };

  # Configure Thunar specifically
  home.file.".config/Thunar/thunarrc".text = ''
    [Configuration]
    DefaultView=ThunarIconView
    LastCompactViewZoomLevel=THUNAR_ZOOM_LEVEL_SMALLER
    LastDetailsViewColumnOrder=THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_MODIFIED
    LastDetailsViewColumnWidths=50,50,50,50
    LastDetailsViewFixedColumns=FALSE
    LastDetailsViewVisibleColumns=THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE
    LastDetailsViewZoomLevel=THUNAR_ZOOM_LEVEL_SMALLER
    LastIconViewZoomLevel=THUNAR_ZOOM_LEVEL_NORMAL
    LastLocationBar=ThunarLocationButtons
    LastSeparatorPosition=170
    LastShowHidden=FALSE
    LastSidePane=ThunarShortcutsPane
    LastSortColumn=THUNAR_COLUMN_NAME
    LastSortOrder=GTK_SORT_ASCENDING
    LastStatusbarVisible=TRUE
    LastView=ThunarIconView
    LastWindowHeight=480
    LastWindowWidth=640
    LastWindowMaximized=FALSE
    MiscVolumeManagement=TRUE
    MiscCaseSensitive=FALSE
    MiscDateStyle=THUNAR_DATE_STYLE_SIMPLE
    MiscFoldersFirst=TRUE
    MiscHorizontalWheelNavigates=FALSE
    MiscRecursivePermissions=THUNAR_RECURSIVE_PERMISSIONS_ASK
    MiscRememberGeometry=TRUE
    MiscShowAboutTemplates=TRUE
    MiscShowThumbnails=TRUE
    MiscSingleClick=FALSE
    MiscSingleClickTimeout=500
    MiscTextBesideIcons=FALSE
    ShortcutsIconEmblems=TRUE
    ShortcutsIconSize=THUNAR_ICON_SIZE_SMALLER
    SidePane=gtk-bookmarks
    TreeIconEmblems=TRUE
    TreeIconSize=THUNAR_ICON_SIZE_SMALLER
  '';
}
