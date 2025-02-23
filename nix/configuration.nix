# Edit this configuration file to define what should be installed onGV
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, inputs, ... }:

let
  # Use unstable channel
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };

in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Enable experimental features/flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    "luks-a601452f-c475-48c2-aae4-466133c51938" = {
      device = "/dev/disk/by-uuid/a601452f-c475-48c2-aae4-466133c51938";
    };
    "second-drive" = {
      device = "/dev/disk/by-uuid/42462bdb-3302-4f01-817e-484ee3fd30e4";
      preLVM = true;
    };
  };
  networking.hostName = "zeus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable TUN/TAP devices for VPN
  boot.kernelModules = [ "tun" ];

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

  # Configure console keymap
  console = {
    useXkbConfig = true;  # This will use the X11 keyboard configuration
  };

  environment.variables = { EDITOR = "vim"; };

  # Enable XRDP with XFCE
  services.xrdp = {
    enable = true;
    #defaultWindowManager = "hyprland";
    openFirewall = true;
  };

  # X11 and display manager configuration
  services.xserver = {
    enable = true;

    # Use LightDM
    displayManager = { lightdm.enable = true; };

    # Only enable XFCE (remove GNOME)
    desktopManager = {
      xfce.enable = true;
      gnome.enable = false; # Disable GNOME
    };

    # Keyboard layout configuration
    xkb = {
      layout = "gb";
      variant = "";
      options = "caps:escape";
    };
  };

  # Move defaultSession here (renamed from services.xserver.displayManager.defaultSession)
  services.displayManager.defaultSession = "xfce";


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
  users.users.martin = {
    isNormalUser = true;
    description = "martin";
    extraGroups =
      [ "networkmanager" "wheel" "docker" "ssl-cert" "libvirtd" "kvm" ];
    useDefaultShell = true;
    packages = with pkgs;
      [

      ];

  };
  users.users.martin.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOg2VKzAytPvs9aArki7JPDyOLjn6+/soebm7JJdNQ5x martin@Lok"
  ];

  # Enable Docker
  virtualisation.docker = { enable = true; };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable Hyprland with proper flake inputs
  programs.hyprland = {
    enable = true;
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enable dbus and other required services
  services.dbus = {
    enable = true;
    packages = [ pkgs.hyprland ];
  };

  # Environment variables for Wayland/Electron
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
  };

  nixpkgs.config.allowUnfree = true;

  # Consolidated system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    nfs-utils
    jq
    wireguard-tools
    curl
    rsync
    acl
    kitty
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xfce.thunar
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    brightnessctl
    wireplumber
    playerctl
    blueman
    virt-manager
    qemu
    OVMF
    swtpm
    spice-gtk
    win-virtio
    slurp
    scrot
    grim
    swappy
    wl-clipboard
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

    # X11 tools
    xorg.xwininfo
    xdotool
    xclip

    # Shell tools
    shfmt
    shellcheck

    # Password in the GUI
    polkit_gnome

    # Tailscale
    tailscale

    # Enable night-mode /blue light filter
    hyprshade

    pyprland
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
    hostKeys = [{
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];
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

  #system.activationScripts.mediaPermissions = {
  #deps = [ "users" "groups" ];
  #text = let
  #setfacl = "${pkgs.acl}/bin/setfacl";
  #in ''
  #echo "Setting up permissions for /mnt and /mnt/media"
  #${setfacl} -m u:martin:rwx /mnt
  #${setfacl} -m u:martin:rwx /mnt/media
  #${setfacl} -R -m u:martin:rwx /mnt/media/*
  #${setfacl} -R -d -m u:martin:rwx /mnt/media/*
  #'';
  #};

  # Define the NFS mounts
  fileSystems."/mnt/media/downloads" = {
    device = "192.168.2.12:/mnt/MasterPool/Media/Downloads";
    fsType = "nfs";
    options = [ "defaults" "_netdev" "user" "nofail" ]; # Add user mount option
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

  fileSystems."/mnt/second-drive" = {
    device = "/dev/mapper/second-drive";
    fsType = "ext4"; # Adjust this if you're using a different filesystem
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.05"; # Did you read the comment?

  # System-wide font configuration
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [ nerd-fonts.jetbrains-mono nerd-fonts.iosevka ];
  };

  # XDG Portal configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
    ];
    config = {
      common = { default = [ "hyprland" ]; };
      hyprland = { default = [ "hyprland" ]; };
    };
  };

  environment.sessionVariables = { NIXOS_XDG_OPEN_USE_PORTAL = "1"; };

  # Enable virtualization
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        package = pkgs.qemu;
      };
    };
    spiceUSBRedirection.enable = true; # Add USB redirection support
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
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };

  # Enable DNS resolution (required for VPN)
  services.resolved.enable = true;

  # Sops configuration. This format is correct and works. It differs from the home-manager format.
  sops = {
    defaultSopsFile = ./packages/sops/secrets.yaml;
    age.keyFile = "/home/martin/.config/sops/age/keys.txt";
    secrets.pia_combined = { };
    secrets.tailscale_preauth = { };
  };

  ## Add this configuration block
  services.pia = {
    enable = true;
    ## Pass credentials from secrets
    authUserPassFile = config.sops.secrets.pia_combined.path;
  };

  # enable the tailscale service
  services.tailscale.enable = true;

  # Add tailscale service and use routes by other nodes in cluster
  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";

      # Add your sops key here
      EnvironmentFile = config.sops.secrets.tailscale_preauth.path;
    };

    # have the job run this shell script
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale using the key from secrets
      ${tailscale}/bin/tailscale up -authkey "$TAILSCALE_AUTH_KEY" --accept-routes=true
    '';
  };

  nix = {
    settings = {
      # Previous download-buffer-size setting remains here
      download-buffer-size = 157286400; # 150MB (150 * 1024 * 1024)

      # Enable automatic optimization (deduplication) of the nix store
      auto-optimise-store = true;
    };

    # Garbage collection settings
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    # Add a periodic optimization service
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # Enable bluetooth and blueman
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Optional: automatically power-on Bluetooth at boot
  };

  # Blueman for bluetooth management
  services.blueman.enable = true;

  # Enable virt-manager
  programs.virt-manager.enable = true;

  # Enable and configure polkit
  security.polkit.enable = true;

  # Start polkit authentication agent
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart =
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

}
