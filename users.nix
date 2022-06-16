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
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDApPBhZ2SrXvpfe9ARU7AWJrLNFl3w1BADTXT6IZaPe+glU7MjyUO0P1unpL+6G1Vgk+EYtfBsjRUxoVp7WxxunIhlhh7XH8Vd8rqCsdF9zqaahA+UfwgsximUxNmDDeLsEr/4yixuINjf88i5Pd0aG4aruXPBuV9K1PXooPzffPgnxu5d6r0PdDRhpoGNw4sp3GXX4gK36VnGlKaLA1mLDIr19RRYkcThl+9UgdJ2XnVsZ81fV4a5fFRo+6HIzD41fNKbSw97N1TCe7rwcvf7UubRq+1AFA29wh2ENSemkATx6aixKaNLF8W9MvJ1lK1qrmqvcyt1UmDpmVN3Vl/xuxTh/i97Llw/AJpb3Avs6DxRVqW+/DA9nfBNDI2vglpIN545wXDRg9smQOv7O8ixvjAgICkH5edtaMwILM9HuA3If0xBGj+cgXk/Z5PVU8fZA7cOdQYyQnfYdvQLyJy2oZTdwMXDf1IHs33zAvgsQcmpLVx0XNsFa5mraYinhlPF5VAPWjzzXSt1qW9j+a1+sKZ0AtuEkTdZjwCdaaI/cLg7c0xlcmITAQ60r/lflQx6GDFQkWj1rpKWrEsWuxfzgHRU07W2JpT9utVqHMkPXOakNmRzSYM/I21YkGS4MAyNbjFnZNLakR12dPbPwnUILhZ1mOKLjRCtv0p7+VS4iQ== isumi@isumi-mipro"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJxg+DsNaapEi5sHalphYKkTOxRILlKbnViCesQ1wvs"
        ];
      };
      nixosvmtest = {
        isNormalUser = true;
        group = "nixosvmtest";
        initialHashedPassword = "$6$30hxpNJ41Xr5.3s4$DsUQi9zpqTp7YMD4.sGs4T3gduJ.1RqWjel7wEKnY2WCwgx6KhyljuRB3UnEL0nzms7m7.p.p/5bGTnnV.waq1";
      };
    };
    groups = {
      nixosvmtest = { };
    };
  };
}

