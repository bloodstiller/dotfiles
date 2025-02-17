{ pkgs, cursor, ... }:

{
  home.packages = with pkgs; [
    # Development Tools
    thefuck
    ripgrep
    fd
    clang
    cmake
    ansible
    vagrant
    
    # Terminal
    oh-my-zsh

    # Applications
    dropbox
    slack
    discord
    google-chrome
    brave
    spotify
    bitwarden
    _1password-cli
    _1password-gui
    
    # Python Development
    (python3.withPackages (ps: with ps; [
      pip
      virtualenv
      poetry-core
    ]))

    # Archives
    zip
    xz
    unzip
    p7zip

    # Networking Tools
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    # Virtualization
    virt-manager

    # Productivity
    hugo
    glow

    # System Tools
    tmux
    age
    btop
    iotop
    iftop
    eza
    fzf
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg 
    sops
    
    # System Call Monitoring
    strace
    ltrace
    lsof

    # Audio
    jamesdsp
    
    # Custom Packages
    cursor
  ];
}
