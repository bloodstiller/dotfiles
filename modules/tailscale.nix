{ config, pkgs, ... }:

{
  services.tailscale.enable = true;

  #Required for resolution when using mullvad.
  services.tailscale.useRoutingFeatures = "client";

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
      ${tailscale}/bin/tailscale up -authkey "$TAILSCALE_AUTH_KEY" --exit-node-allow-lan-access --exit-node=gb-mnc-wg-201.mullvad.ts.net --accept-routes=true --reset --acccept-dns=true

    '';
  };
  environment.systemPackages = with pkgs; [ tailscale jq ];
}
