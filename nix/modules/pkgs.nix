{ pkgs, ... }:

# Consolidated system packages
{
  environment.systemPackages = with pkgs; [
    # Core System Utilities
    vim
    wget
    git
    curl
    rsync
    acl
    ispell
    which
    wireguard-tools

    # Development tools
    gnumake
    gcc
    cmake

    # Python Development
    python311Packages.pyflakes
    python311Packages.isort
    python311Packages.pytest
    python311Packages.setuptools

    # Development Support
    nixfmt-classic
    grip
    libxml2 # Provides xmllint
    shfmt
    shellcheck

    # System Integration
    polkit_gnome

    # video
    vlc

    # Archiver
    file-roller
  ];
}
