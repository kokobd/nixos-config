{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, agenix }: {
    nixosConfigurations = let
      buildMachine = { system, module }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            module
            home-manager.nixosModules.home-manager
            {
              config.home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kokobd = import ./kokobd;
              };
            }
          ];
        };
    in {
      kokobd-desktop = buildMachine {
        system = "x86_64-linux";
        module = ./machines/nuc11.nix;
      };

      aws-ec2 = buildMachine {
        system = "x86_64-linux";
        module = ./machines/aws-ec2.nix;
      };
    };
  };
}
