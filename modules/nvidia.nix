{ config, lib, pkgs, ... }:

{
  # Enable Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required for most Wayland compositors
    modesetting.enable = true;

    # Enable power management
    powerManagement = {
      enable = true;
      finegrained = true;
    };

    # Use the NVidia closed source driver
    open = true;

    # Enable the Nvidia settings menu
    nvidiaSettings = true;

    # Required for Wayland
    forceFullCompositionPipeline = true;

    # Prime configuration
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Bus IDs from your lspci output
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    # Package configuration
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Nvidia-specific packages
  environment.systemPackages = with pkgs; [ glxinfo vulkan-tools ];
}
