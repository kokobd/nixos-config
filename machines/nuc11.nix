{ pkgs, ... }:

{
  imports = [ ./nuc11-hardware.nix ../modules/graphical.nix ];

  config = {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };

    networking = let
      interfaceConf = {
        useDHCP = false;

        ipv4.addresses = [{
          address = "192.168.31.3";
          prefixLength = 16;
        }];
      };
    in {
      hostName = "nuc11";
      networkmanager.enable = true;
      firewall.enable = false;

      interfaces.enp89s0 = interfaceConf;
      # interfaces.wlo1 = interfaceConf;

      defaultGateway = "192.168.31.2";
      nameservers = [ "8.8.8.8" ];
    };
  };
}
