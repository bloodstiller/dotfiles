{
  description = "Laptop configuration";

  inputs = {
    # Use nixos-unstable or nixpkgs-unstable instead of versioned channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url =
      "github:NixOS/nixpkgs/nixos-unstable"; # Unstable channel

    # Use main branch instead of release-25.05
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add agenix as an input
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add sops
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add hyprland and related packages
    hyprland.url = "github:hyprwm/Hyprland";

    # Add separate inputs for hypridle and hyprlock
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add pyprland
    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add hardware-specific optimizations
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # NFV for neovim config
    nvf.url = "github:notashelf/nvf";

    # Add nix-colors for theming (optional)
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, agenix, sops-nix
    , hyprland, hypridle, hyprlock, pyprland, nixos-hardware, nix-colors, nvf
    , ... }@inputs: {

      packages."x86_64-linux".default = let
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        nvimConfig = (nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [ ./packages/nvim/nvf-configuration.nix ];
        }).neovim;
      in pkgs.symlinkJoin {
        name = "nvim-custom";
        pname = "nvim-custom";
        version = "1.0.0";

        paths = [ nvimConfig ];
        # Tell nix run which binary to execute
        meta = {
          mainProgram = "nvim"; # The actual binary name
        };

        # Optional: add a wrapper script if needed
        postBuild = ''
          # Any post-processing if needed
        '';
      };

      nixosConfigurations.zeus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          agenix.nixosModules.age
          sops-nix.nixosModules.sops

          # Add hardware-specific optimizations if needed
          # nixos-hardware.nixosModules.dell-xps-15-9560  # Example, replace with your model

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; };
              users.martin = import ./packages/home-manager/home.nix;
              sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
            };
          }
          {
            environment.systemPackages =
              [ agenix.packages.x86_64-linux.default ];
          }
        ];
      };
    };
}
