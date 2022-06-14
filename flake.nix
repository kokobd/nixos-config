{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        nuc11 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix

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
      };
    };
}
