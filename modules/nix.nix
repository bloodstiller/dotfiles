{ config, ... }:

{
  nixpkgs.config.allowUnfree = true; # Allow proprietary software

  home-manager.backupFileExtension = "backup";

  nix = {
    settings = {
      # Enable experimental features
      experimental-features = [ "nix-command" "flakes" ];

      # Previous download-buffer-size setting remains here
      download-buffer-size = 157286400; # 150MB (150 * 1024 * 1024)

      # Enable automatic optimization (deduplication) of the nix store
      auto-optimise-store = true;
    };

    # Garbage collection settings
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    # Add a periodic optimization service
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };
}
