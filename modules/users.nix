{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = false;
    users = {
      kokobd = {
        isNormalUser = true;
        description = "Kobayashi";
        extraGroups = [ "networkmanager" "wheel" ];
        hashedPassword =
          "$6$QVXhv9ojOXVZATu4$/I/uuCUU.hrbE71HJNSXgyLAeJEYWYMLjkvtsOIXC1kWERP8bsEYuGYIGFgfHKQ.95wqKZxC8pZaMJ8J9b1MB/";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJxg+DsNaapEi5sHalphYKkTOxRILlKbnViCesQ1wvs"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM1Btv7KbzDNEMryy2O6lEtkfUzpRpvUhw+pvNlYotBL kokobd@MacBook-Air.local"
        ];
      };
      nixosvmtest = {
        isNormalUser = true;
        group = "nixosvmtest";
        initialHashedPassword =
          "$6$30hxpNJ41Xr5.3s4$DsUQi9zpqTp7YMD4.sGs4T3gduJ.1RqWjel7wEKnY2WCwgx6KhyljuRB3UnEL0nzms7m7.p.p/5bGTnnV.waq1";
      };
    };
    groups = { nixosvmtest = { }; };
  };
}

