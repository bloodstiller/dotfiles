{ pkgs, cursor, ... }:

{
  home.packages = with pkgs; [
    # Development Tools
    thefuck
    ripgrep
    fd
    clang
    ansible

    # Python Development
    (python3.withPackages (ps: with ps; [ pip virtualenv poetry-core ]))

    # Applications
    discord
    brave
    spotify
    bitwarden
    firefox

    # Shell & Terminal
    tmux
    eza
    fzf
    tree

    # Archives & File Tools
    zip
    xz
    unzip
    p7zip
    file

    # Networking Tools
    dnsutils
    nmap

    # Monitoring & Debug Tools
    btop
    iotop
    iftop
    strace
    ltrace
    lsof

    # Productivity & Documentation
    hugo

    # Security & Encryption
    age
    gnupg
    sops

    # Audio
    jamesdsp

    # Custom & UI
    cursor
  ];
}
