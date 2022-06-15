{
  secrets = {
    "passwords.kdbx" = {
      file = ./secrets/passwords.kdbx.age;
      path = "/home/kokobd/Documents/passwords.kdbx";
      owner = "kokobd";
    };
    "passwords.key" = {
      file = ./secrets/passwords.key.age;
      path = "/home/kokobd/Documents/passwords.key";
      owner = "kokobd";
    };
    "id_ed25519" = {
      file = ./secrets/id_ed25519.age;
      path = "/home/kokobd/.ssh/id_ed25519";
      owner = "kokobd";
    };
  };
}
