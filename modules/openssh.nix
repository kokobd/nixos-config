{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      openssh = prev.openssh.overrideAttrs
        (old: { patches = (old.patches or [ ]) ++ [ ./openssh.patch ]; });
    })
  ];
}
