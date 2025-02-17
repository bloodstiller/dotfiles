{ config, ... }:

{
  sops = {
    age.keyFile = "/home/martin/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";

    secrets = {
      work_email = {
        path = "${config.sops.defaultSymlinkPath}/work_email";
      };
      pia_combined = {
        path = "${config.sops.defaultSymlinkPath}/pia_combined";
      };
      pia_user = {
        path = "${config.sops.defaultSymlinkPath}/pia_user";
      };
      pia_pass = {
        path = "${config.sops.defaultSymlinkPath}/pia_pass";
      };
      scoop = {
        path = "${config.sops.defaultSymlinkPath}/scoop";
      };
      gobo = {
        path = "${config.sops.defaultSymlinkPath}/gobo";
      };
      wing = {
        path = "${config.sops.defaultSymlinkPath}/wing";
      };
      mirk = {
        path = "${config.sops.defaultSymlinkPath}/mirk";
      };
      sand = {
        path = "${config.sops.defaultSymlinkPath}/sand";
      };
      boop = {
        path = "${config.sops.defaultSymlinkPath}/boop";
      };
      sally = {
        path = "${config.sops.defaultSymlinkPath}/sally";
      };
    };
  };
} 