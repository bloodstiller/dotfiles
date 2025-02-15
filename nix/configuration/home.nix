{ config, pkgs, inputs, ... }:

let
  cursor = pkgs.callPackage ./packages/cursor.nix {};
in
{
  # Set Home Manager State Version
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

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

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
      
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

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # Shell Configuration
  programs = {
    # ZSH Configuration
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      
      # Add (this is done as otherwise nix will overwrite with the default aliases) 
      shellAliases = {
        ls = "eza -T -L=1 -a -B -h -l -g --icons";
        lsl = "eza -T -L=2 -a -B -h -l -g --icons";
        lss = "eza -T -L=1 -B -h -l -g --icons";
        cat = "bat";
        history = "history 0";
        host-update = "sudo nixos-rebuild switch";
        home-update = "home-manager switch";
      };

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1";
            sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
          };
        }
      ];

      oh-my-zsh = {
        enable = true;
        plugins = [ 
          "git" 
          "history" 
          "tmux" 
          "history" 
          "docker-compose"
        ];
        theme = "robbyrussell";
      };
      
      # Add custom.zsh to zsh config to source my custom zshrc
      initExtra = ''
        if [ -f "~/.config/zsh/custom.zsh" ]; then
          source "~/.config/zsh/custom.zsh"
        fi
        export WORK_EMAIL=$(cat ${config.sops.secrets.work_email.path})
      '';
    };

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
        source ../../ux/.tmux.conf
        
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
      source = ../../doom;
      recursive = true;
    };
    
    ".config/alacritty" = {
      source = ../../alacritty;
      recursive = true;
    };

    # Shell Config
    ".config/starship.toml".source = ../../starship/starship.toml;

    # Window Manager Config
    ".config/hypr" = {
      source = ../../hypr;
      recursive = true;
    };

    # Application Config
    ".config/dunst" = {
      source = ../../dunst;
      recursive = true;
    };
    
    ".config/wofi" = {
      source = ../../wofi;
      recursive = true;
    };
    
    ".config/waybar" = {
      source = ../../waybar;
      recursive = true;
    };

    # Scripts
    ".config/scripts" = {
      source = ../../scripts;
      executable = true;
    };

    # ZSH Config Directory
    ".config/zsh" = {
      source = ../../zsh;
      recursive = true;
    };

    # Add custom.zsh to managed files
    ".config/zsh/custom.zsh".source = ../../zsh/custom.zsh;

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

  ## Add sops-nix configuration
  sops = {
    age.keyFile = "/home/martin/.config/sops/age/keys.txt";
    defaultSopsFile = ./home-manager/sops/secrets.yaml;
    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";

    secrets.work_email = {
      path = "${config.sops.defaultSymlinkPath}/work_email";
    };
  };
  
  # Update the age.secrets section
  #age.secrets = {
    #git-credentials = {

      #file = ../../crets/git-credentials.age;
      #owner = "martin";
      #group = "users";
      #mode = "0400";
    #};
  #};
}


