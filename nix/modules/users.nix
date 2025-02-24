{ pkgs, ... }:

{   
  # Enable zsh system-wide
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. 
  users.users.martin = {
    isNormalUser = true;
    description = "martin";
    extraGroups = [
      "networkmanager"
      "wheel"  # Enable sudo
      "docker"
      "ssl-cert"
      "libvirtd"  # For VM management
      "kvm"
    ];
  };

  users.users.martin.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOg2VKzAytPvs9aArki7JPDyOLjn6+/soebm7JJdNQ5x martin@Lok"
  ];
}
