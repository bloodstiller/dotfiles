{ config, pkgs, inputs, ... }:

let
  cursor = pkgs.callPackage ../cursor/cursor.nix {};
in
{
  imports = [
    (import ../packages/packages.nix {
      inherit pkgs cursor;
    })
    ../alacritty/alacritty.nix
    ../doom/doom.nix
    ../dropbox/dropbox.nix
    ../dunst/dunst.nix
    ../hypr/hyprland.nix
    ../Pia/pia.nix
    ../scripts/scripts.nix
    ../sops/sops.nix
    ../starship/starship.nix
    ../tmux/tmux.nix
    ../waybar/waybar.nix
    ../wofi/wofi.nix
    ../zsh/zsh.nix
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
    
    # Atuin Configuration for syncing shell history accross machines
    atuin = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      
      settings = {
        sync_address = "https://api.atuin.sh";
        sync_frequency = "5m";
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

  };


  # Enable Services
  programs = {
    wofi.enable = true;
    waybar.enable = true;
  };
}


