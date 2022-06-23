{ pkgs, ... }:

{
  imports = [ ./nuc11-hardware.nix ../modules/graphical.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  networking = {
    hostName = "kokobd-desktop";
    networkmanager.enable = true;
    firewall.enable = false;

    interfaces.enp89s0 = {
      useDHCP = false;

      ipv4.addresses = [{
        address = "192.168.31.3";
        prefixLength = 16;
      }];
    };

    defaultGateway = "192.168.31.2";
    nameservers = [ "8.8.8.8" ];
  };
}
