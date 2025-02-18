{
  description = "Laptop configuration";

  inputs = {
    # Use nixos-unstable or nixpkgs-unstable instead of versioned channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Use main branch instead of release-24.11
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add agenix as an input
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add PIA
    pia = {
      url = "github:Fuwn/pia.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add pyprland
    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, pia, sops-nix, hyprland, pyprland, ... }@inputs: {
    nixosConfigurations.zeus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        agenix.nixosModules.age
        pia.nixosModules."x86_64-linux".default
        sops-nix.nixosModules.sops

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs;
            };
            users.martin = import ./packages/home-manager/home.nix;
            sharedModules = [
              inputs.sops-nix.homeManagerModules.sops
            ];
          };
        }
        {
          environment.systemPackages = [ 
            agenix.packages.x86_64-linux.default
            home-manager.packages.x86_64-linux.home-manager
            hyprland.packages.x86_64-linux.default
            pyprland.packages.x86_64-linux.default
          ];
        }
      ];
    };
  };
}
