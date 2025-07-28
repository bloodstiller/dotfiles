{ pkgs, ... }:

{

  # services.xrdp = {
  #   enable = true;
  #   openFirewall = true;
  # };

  # X11 and display manager configuration
  services.xserver = {
    enable = true;

    # Use LightDM
    displayManager = { lightdm.enable = true; };

    # Only enable XFCE (remove GNOME)
    desktopManager = { xfce.enable = true; };

  };
  environment.systemPackages = with pkgs; [
    xfce.thunar
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    xorg.xwininfo
    xdotool
    xclip
  ];
}
