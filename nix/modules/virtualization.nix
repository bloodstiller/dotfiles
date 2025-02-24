{ pkgs, ... }:

{
  # Enable virt-manager GUI application
  programs.virt-manager.enable = true;

  virtualisation = {
    docker.enable = true;
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

  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
    swtpm
    pkgs.OVMF
    spice-gtk
    win-virtio
  ];
}

