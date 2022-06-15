# nixos-config

My personal NixOS config

To apply this to a fresh NixOS instance, the following steps must be applied in order:

1. Copy `nix = ` from `configuration.nix` to the new system's `configuration.nix`, and
  apply it to the system. This enables `nix flake`
2. Copy all files from this repo into /etc/nixos, excluding `.git`,
  `hardware-configuration.nix`, and `boot.loader` (in `configuration.nix`)
3. Run `sudo nixos-rebuild switch .#nuc11` (specify the host name explicitly)
4. Now the configurations are fully applied, subsequent calls to `nixos-rebuild` should
  work normally.
