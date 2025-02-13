{ config, pkgs, ... }:

let
  cursor = pkgs.callPackage ./packages/cursor.nix {};
in
{
  # Basic Home Manager Configuration
  home = {
    username = "martin";
    homeDirectory = "/home/martin";
    stateVersion = "25.05";
    
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

      # System Tools
      btop
      tmux
      
      # Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      
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
      
      # Virtualization
      virt-manager
      
      # Audio
      jamesdsp
      
      # Custom Packages
      cursor
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
        if [ -f "${config.home.homeDirectory}/.config/zsh/custom.zsh" ]; then
          source "${config.home.homeDirectory}/.config/zsh/custom.zsh"
        fi
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

      includes = [{
        condition = "gitdir:~/.config/work/";
        contents = {
          user = {
            email = "mbarker@babblevoice.com";
            name = "Martin Barker";
          };
        };
      }];
    };

    # Tmux Configuration
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
      ];
      
      extraConfig = ''
        source ${config.home.homeDirectory}/.dotfiles/tmux/.tmux.conf
        
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
      source = ~/.dotfiles/doom;
      recursive = true;
    };
    
    ".config/alacritty" = {
      source = ~/.dotfiles/alacritty;
      recursive = true;
    };

    # Shell Config
    #".zshrc".source = ~/.dotfiles/zsh/.zshrc;
    ".config/starship.toml".source = ~/.dotfiles/starship/starship.toml;

    # Window Manager Config
    ".config/hypr" = {
      source = ~/.dotfiles/hypr;
      recursive = true;
    };

    # Application Config
    ".config/dunst" = {
      source = ~/.dotfiles/dunst;
      recursive = true;
    };
    
    ".config/wofi" = {
      source = ~/.dotfiles/wofi;
      recursive = true;
    };
    
    ".config/waybar" = {
      source = ~/.dotfiles/waybar;
      recursive = true;
    };

    # Scripts
    ".config/scripts" = {
      source = ~/.dotfiles/scripts;
      executable = true;
    };

    # ZSH Config Directory
    ".config/zsh" = {
      source = ~/.dotfiles/zsh;
      recursive = true;
    };

    # Add custom.zsh to managed files
    ".config/zsh/custom.zsh".source = ~/.dotfiles/zsh/custom.zsh;

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

  # Enable Services
  services.dunst.enable = true;
  programs = {
    wofi.enable = true;
    waybar.enable = true;
    home-manager.enable = true;
  };
}
