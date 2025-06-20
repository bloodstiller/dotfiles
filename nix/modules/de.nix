{ pkgs, inputs, ... }:

{

  # Set hyprland as the default display manager
  services.displayManager.defaultSession = "hyprland";

  # System-level configuration
  programs.hyprland = {
    enable = true;
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enable dbus and other required services
  services.dbus = {
    enable = true;
    packages = [ pkgs.hyprland ];
  };

  # Environment variables for Wayland/Electron
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    # Ensure MIME type handling works correctly
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  # XDG Portal configuration
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
    ];
    config.common.default = [ "hyprland" "gtk" ];
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-utils
    brightnessctl
    wireplumber
    playerctl

    # Additional packages for MIME type support
    shared-mime-info
    desktop-file-utils
    gtk3 # For GTK applications integration
  ];
}
