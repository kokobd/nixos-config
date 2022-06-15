let publicKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzkrWzro00IegCbggBCfvWxjlT+GOl4aSGbLp7WIVxC root@nuc11" ];
in
{
  "passwords.kdbx.age" = { inherit publicKeys; };
  "passwords.key.age" = { inherit publicKeys; };
  "id_ed25519.age" = { inherit publicKeys; };
}

