{ lib }:
let
  mergeAttrs = lib.attrsets.foldAttrs (val: col: val) 0;

  mkUserSecret = { name, dir }:
    lib.attrsets.setAttrByPath [ name ] {
      file = ./secrets + "/${name}.age";
      path = "/home/kokobd/${dir}/${name}";
      owner = "kokobd";
    };

  mkUserSecrets = secrets: mergeAttrs (map mkUserSecret secrets);
in {
  secrets = mkUserSecrets [
    {
      name = "passwords.kdbx";
      dir = "Documents";
    }
    {
      name = "passwords.key";
      dir = "Documents";
    }
    {
      name = "id_ed25519";
      dir = ".ssh";
    }
  ];
}
