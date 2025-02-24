{ pkgs, ... }:

{

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
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "defaults" "_netdev" "nofail" ];
  };

  fileSystems."/mnt/media/movies" = {
    device = "192.168.2.12:/mnt/MasterPool/Media/Movies";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "defaults" "_netdev" "nofail" ];
  };

  fileSystems."/mnt/media/tv" = {
    device = "192.168.2.12:/mnt/MasterPool/Media/TV";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "defaults" "_netdev" "nofail" ];
  };

  fileSystems."/mnt/media/music" = {
    device = "192.168.2.12:/mnt/MasterPool/Media/Music";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "defaults" "_netdev" "nofail" ];
  };

  fileSystems."/mnt/second-drive" = {
    device = "/dev/mapper/second-drive";
    fsType = "ext4";
  };

  environment.systemPackages = with pkgs; [
    nfs-utils
  ];
}
