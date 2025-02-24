{ ... }:

{
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
}
