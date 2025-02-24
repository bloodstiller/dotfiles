{ pkgs, ... }:


# Consolidated system packages
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    wireguard-tools
    curl
    rsync
    acl
    ispell

    # Development tools
    gnumake
    gcc
    cmake

    # LSP and development dependencies
    python311Packages.pyflakes
    python311Packages.isort
    python311Packages.pytest
    python311Packages.setuptools

    # Nix tools
    nixfmt-classic

    # Markdown tools
    grip

    # XML tools
    libxml2 # Provides xmllint

    # Shell tools
    shfmt
    shellcheck

    # Password in the GUI
    polkit_gnome
  ];
}