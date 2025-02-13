   #!/bin/bash
   # sync.sh

   # Ensure secrets directory exists
   mkdir -p secrets

   # Sync .age files from /etc/secrets to repo
   cp /etc/secrets/*.age secrets/

   # Optional: Show what changed
   echo "Updated secrets:"
   ls -la secrets/

   # Sync hardware-configuration.nix
   cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
   echo "Updated hardware-configuration.nix"

   # Sync configuration.nix
   cp /etc/nixos/configuration.nix ./configuration.nix
   echo "Updated configuration.nix"

