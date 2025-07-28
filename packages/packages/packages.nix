{ pkgs, cursor, inputs, ... }:

{
  home.packages = with pkgs; [
    # Development Tools
    ripgrep
    fd
    clang

    # Python Development
    (python3.withPackages (ps: with ps; [ pip virtualenv poetry-core ]))

    # Applications
    discord
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
    exiftool

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

    # Security & Encryption
    age
    gnupg
    sops

    # Audio
    jamesdsp

    # Custom & UI
    cursor

    # Blogging
    hugo

    # Nextcloud using unstable as better
    #
    #nextcloud-client
    (inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.nextcloud-client)

    # video
    vlc
    ffmpeg

    # audio
    strawberry
    picard

    # office
    libreoffice-fresh
    teams-for-linux

    # Markdown
    marksman
    pandoc

    # Recovery
    #ddrescue
    #testdisk-qt
    #foremost
    #

    # Temp

  ];
}
