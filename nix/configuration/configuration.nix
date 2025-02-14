# Edit this configuration file to define what should be installed onGV
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:


let
  # Use unstable channel
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable experimental features/flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/boot/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk = true;

  boot.initrd.luks.devices."luks-e29431c5-61b9-42a8-9ad3-878f8bc2889f".keyFile = "/boot/crypto_keyfile.bin";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };


  environment.variables = {
    EDITOR = "vim";
  };

  # Enable XRDP with XFCE
  services.xrdp = {
    enable = true;
    defaultWindowManager = "startxfce4";
    openFirewall = true;
  };

  # X11 and display manager configuration
  services.xserver = {
    enable = true;
    
    # Use LightDM
    displayManager = {
      lightdm.enable = true;
    };

    # Only enable XFCE (remove GNOME)
    desktopManager = {
      xfce.enable = true;
      gnome.enable = false;  # Disable GNOME
    };
    
    # Keyboard layout configuration
    xkb = {
      layout = "gb";
      variant = "";
    };
  };

  # Move defaultSession here (renamed from services.xserver.displayManager.defaultSession)
  services.displayManager.defaultSession = "xfce";

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;  

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.martin ={
    isNormalUser = true;
    description = "martin";
    extraGroups = [ "networkmanager" "wheel" "docker" "ssl-cert" "libvirtd" "kvm" ];
    useDefaultShell = true;
    packages = with pkgs; [
    ];
  };
  users.users.martin.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOg2VKzAytPvs9aArki7JPDyOLjn6+/soebm7JJdNQ5x martin@Lok" 
  ];
 
    # Enable Docker
  virtualisation.docker = {
    enable = true;
  };

  # Install firefox.
  programs.firefox.enable = true;

 # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };


# Enable dbus and other required services
  services.dbus.enable = true;

  # Environment variables for Wayland/Electron
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # Hint Electron apps to use Wayland
  };

  nixpkgs.config.allowUnfree = true;

  # Consolidated system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    nfs-utils
    rsync
    acl
    kitty
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xfce.thunar
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    # Add any other system packages you need here
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # Create mount points with correct permissions
  systemd.tmpfiles.rules = [
    "d /mnt 0755 root root -"
    "d /mnt/media 0755 martin martin -"
    "d /mnt/media/downloads 0755 martin martin -"
    "d /mnt/media/movies 0755 martin martin -"
    "d /mnt/media/tv 0755 martin martin -"
    "d /mnt/media/music 0755 martin martin -"
  ];

  # Set up ACLs for mount points
  system.activationScripts.mediaPermissions = {
    deps = [ "users" "groups" ];
    text = let
      setfacl = "${pkgs.acl}/bin/setfacl";
    in ''
      echo "Setting up permissions for /mnt and /mnt/media"
      ${setfacl} -m u:martin:rwx /mnt
      ${setfacl} -m u:martin:rwx /mnt/media
      ${setfacl} -R -m u:martin:rwx /mnt/media/*
      ${setfacl} -R -d -m u:martin:rwx /mnt/media/*
    '';
  };

  # Define the NFS mounts
  fileSystems."/mnt/media/downloads" = {
    device = "192.168.2.12:/mnt/MasterPool/Media/Downloads";
    fsType = "nfs";
    options = [ "defaults" "_netdev" "user" "nofail" ];  # Add user mount option
  };

  fileSystems."/mnt/media/movies" = {
    device = "192.168.2.12:/mnt/MasterPool/Media/Movies";
    fsType = "nfs";
    options = [ "defaults" "_netdev" "user" "nofail" ];
  };

  fileSystems."/mnt/media/tv" = {
    device = "192.168.2.12:/mnt/MasterPool/Media/TV";
    fsType = "nfs";
    options = [ "defaults" "_netdev" "user" "nofail" ];
  };

  fileSystems."/mnt/media/music" = {
    device = "192.168.2.12:/mnt/MasterPool/Media/Music";
    fsType = "nfs";
    options = [ "defaults" "_netdev" "user" "nofail" ];
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11"; # Did you read the comment?


  # System-wide font configuration
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
    ];
  };

  # XDG Portal configuration - simplified for Hyprland and XFCE
 
 # XDG Portal configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        default = ["hyprland"];
      };
      hyprland = {
        default = ["hyprland"];
      };
    };
  };

  environment.sessionVariables = {
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
  };

  # Enable virtualization
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
      };
    };
  };

# Enable AppImage support 
programs.appimage.enable = true;
programs.appimage.binfmt = true;
# Enable AppImage support 
boot.binfmt.registrations.appimage = {
  wrapInterpreterInShell = false;
  interpreter = "${pkgs.appimage-run}/bin/appimage-run";
  recognitionType = "magic";
  offset = 0;
  mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
  magicOrExtension = ''\x7fELF....AI\x02'';
};

  #age.secrets.pia-credentials = {
    #file = ./secrets/pia-credentials.age;
  #};

  ## Add this configuration block
  #services.pia = {
    #enable = true;
    ## Pass credentials from secrets
    #authUserPassFile = config.age.secrets.pia-credentials.path;
  #};
}
