# Network configuration
{ pkgs, ... }:

{
  networking.hostName = "zeus";
  networking.networkmanager.enable = true;

  # Enable TUN/TAP devices for VPN
  boot.kernelModules = [ "tun" ];

  # Enable DNS resolution (required for VPN)
  services.resolved.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    hostKeys = [{
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];
  };

}
