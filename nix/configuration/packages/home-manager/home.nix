{ config, pkgs, inputs, ... }:

let
  cursor = pkgs.callPackage ../cursor/cursor.nix {};
in
{
  imports = [
    ../zsh/zsh.nix  # Update the path to match your actual file structure
    ../sops/sops.nix
  ];

  # Set Home Manager State Version
  home.stateVersion = "25.05";

  # Basic Home Manager Configuration
  home = {
    username = "martin";
    homeDirectory = "/home/martin";
    
    # Session Variables
    sessionVariables = {
      EDITOR = "vim";
    };
    
    # System Packages
    packages = with pkgs; [
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
 
      # archives
      zip
      xz
      unzip
      p7zip

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      dnsutils  # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      aria2 # A lightweight multi-protocol & multi-source command-line download utility
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc  # it is a calculator for the IPv4/v6 addresses


      # Virtualization
      virt-manager
      # productivity

      hugo # static site generator
      glow # markdown previewer in terminal

      # System Tools
      tmux
      age
      btop  # replacement of htop/nmon
      iotop # io monitoring
      iftop # network monitoring
      eza # A modern replacement for 'ls'
      fzf # A command-line fuzzy finder     
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
     
      # system call monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      lsof # list open files 
      # Audio
      jamesdsp
      
      # Custom Packages
      cursor

      # Imported from pyprland flake (does not expose a normal output just a flake input)
    ];
  };

  programs = {
    # Terminal Emulators
    alacritty = {
      enable = true;
    };

    # For hyprland
    kitty.enable = true;

    # Development Tools
    emacs = {
      enable = true;
      package = pkgs.emacs29;
    };

    # CLI Tools
    eza.enable = true;
    bat.enable = true;
    starship.enable = true;

    # Git Configuration
    git = {
      enable = true;
      userName = "bloodstiller";
      userEmail = "bloodstiller@bloodstiller.com";
      
      signing = {
        key = null;  # Set your signing key here if you use one
        signByDefault = false;
        format = "ssh";  # or "gpg" if you prefer GPG signing
      };
      
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
        core.editor = "vim";
        credential.helper = "store";
      };

      #includes = [{
        #condition = "gitdir:~/.config/work/";
        #contents = let
          #credentials = builtins.readFile config.age.secrets.git-credentials.path;
          ## Parse the credentials file content
          #parsedCredentials = builtins.fromJSON (builtins.toJSON {
            #work_email = builtins.match "work_email=(.*)" credentials;
            #work_name = builtins.match "work_name=(.*)" credentials;
          #});
        #in {
          #user = {
            #email = parsedCredentials.work_email;
            #name = parsedCredentials.work_name;
          #};
        #};
      #}];
    };

    # Tmux Configuration
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
      ];
      
      extraConfig = ''
        source ../../tmux/.tmux.conf
        
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        
        run '~/.tmux/plugins/tpm/tpm'
      '';
    };
  };

  # Window Manager Configuration
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    xwayland.enable = true;
    
    settings = {
      monitor = ",preferred,auto,1";
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        no_cursor_warps = true;
        no_focus_fallback = true;
      };
    };
  };

  # Theme Configuration
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };

  # Dotfile Management
  home.file = {
    # TPM Installation
    ".tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "99469c4a9b1ccf77fade25842dc7bafbc8ce9946";
      sha256 = "hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
    };

    # Config Files
    ".config/doom" = {
      source = ../../../../doom;
      recursive = true;
    };
    
    ".config/alacritty" = {
      source = ../../../../alacritty;
      recursive = true;
    };

    # Shell Config
    ".config/starship.toml".source = ../../../../starship/starship.toml;

    # Window Manager Config
    ".config/hypr" = {
      source = ../../../../hypr;
      recursive = true;
    };

    # Application Config
    ".config/dunst" = {
      source = ../../../../dunst;
      recursive = true;
    };
    
    ".config/wofi" = {
      source = ../../../../wofi;
      recursive = true;
    };
    
    ".config/waybar" = {
      source = ../../../../waybar;
      recursive = true;
    };

    # Scripts
    ".config/scripts" = {
      source = ../../../../scripts;
      executable = true;
    };

    


    # Add PIA manual connections repo
    "Pia".source = pkgs.fetchFromGitHub {
      owner = "pia-foss";
      repo = "manual-connections";
      rev = "e956c57849a38f912e654e0357f5ae456dfd1742";  
      sha256 = "otDaC45eeDbu0HCoseVOU1oxRlj6A9ChTWTSEUNtuaI=";
    };

  };

  # Service Configuration
  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
    };
  };

  # Conditionally enable Dunst only when using Hyprland
  services.dunst = {
    enable = true;
    # Only start Dunst if we're in a Hyprland session
    waylandDisplay = "wayland-1";
  };

  # Enable Services
  programs = {
    wofi.enable = true;
    waybar.enable = true;
  };
}


