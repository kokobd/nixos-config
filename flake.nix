{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, agenix }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        kokobd-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hardware-configuration.nix
            ./bootloader.nix
            ./configuration.nix
            ./gpg.nix
            ./users.nix
            ./nixtool.nix
            ./packages.nix
            ./sleep.nix
            ./age.nix
            agenix.nixosModule

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
