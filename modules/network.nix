# Network configuration
{ pkgs, ... }:

{

  networking.hostName = "zeus";
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved"; # Ensure NetworkManager plays nice with resolved
  };

  # DNS settings: prioritize local, then fallback
  networking.nameservers =
    [ "192.168.2.136" "192.168.2.195" "1.1.1.1" "8.8.8.8" ];

  # Enable TUN/TAP devices for VPN
  boot.kernelModules = [ "tun" ];

  # Enable DNS resolution (required for VPN)
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
    #dnssec = "false";  # optional; some local resolvers don’t support DNSSEC well
  };

  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;
    hostKeys = [{
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];
  };

  #networking.extraHosts = ''
  # 192.168.2.113 radarr.homelab.bloodstiller.com sonarr.homelab.bloodstiller.com navidrome.homelab.bloodstiller.com nextcloud.homelab.bloodstiller.com
  #192.168.2.12 truenas.homelab.bloodstiller.com

  # '';

  services.resolved.extraConfig = ''
    DNS=192.168.2.136 192.168.2.195
    FallbackDNS=1.1.1.1 8.8.8.8
    Domains=~.
  '';

}
