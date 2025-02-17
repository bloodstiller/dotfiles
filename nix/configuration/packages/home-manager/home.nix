{ config, pkgs, inputs, ... }:

let
  cursor = pkgs.callPackage ../cursor/cursor.nix {};
in
{
  imports = [
    (import ../programs/programs.nix {
      inherit pkgs cursor;
    })
    ../alacritty/alacritty.nix
    ../sops/sops.nix
    ../tmux/tmux.nix
    ../waybar/waybar.nix
    ../wofi/wofi.nix
    ../zsh/zsh.nix
    ../starship/starship.nix
    ../doom/doom.nix
    ../dunst/dunst.nix
    ../scripts/scripts.nix
    ../Pia/pia.nix
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
  };
  
  programs = {
    # For hyprland
    kitty.enable = true;

    # CLI Tools
    eza.enable = true;
    bat.enable = true;

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

    
    # Window Manager Config
    ".config/hypr" = {
      source = ../../../../hypr;
      recursive = true;
    };

    
    # Scripts
    ".config/scripts" = {
      source = ../../scripts;
      executable = true;
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


  # Enable Services
  programs = {
    wofi.enable = true;
    waybar.enable = true;
  };
}


