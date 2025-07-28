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
        vhostUserPackages = with pkgs; [ virtiofsd ];
      };
    };
    spiceUSBRedirection.enable = true; # Add USB redirection support

    # Enable VirtualBox
    #virtualbox = {
    #host = {
    #enable = true;
    #enableExtensionPack =
    #true; # Enables USB 2.0/3.0, disk encryption, and more
    #};
    #};
  };

  environment.systemPackages = with pkgs; [
    # Only keeping packages that aren't enabled through other options
    spice-gtk
    win-virtio
    vagrant
    virtiofsd
  ];
}

