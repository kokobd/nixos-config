{ ... }:

{
  networking = {
    hostName = "kokobd-desktop";
    networkmanager.enable = true;
    firewall.enable = false;

    interfaces.enp89s0.ipv4.addresses = [{
      address = "192.168.31.3";
      prefixLength = 16;
    }];

    defaultGateway = "192.168.31.2";
    nameservers = [ "8.8.8.8" ];
  };
}
