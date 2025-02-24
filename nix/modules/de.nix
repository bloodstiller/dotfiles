{ pkgs, inputs, ... }:

{
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
  };

  # XDG Portal configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
    ];
    config.common.default = [ "hyprland" ];
    config.hyprland.default = [ "hyprland" ];
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    brightnessctl
    wireplumber
    playerctl
  ];
}