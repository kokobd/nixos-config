{ config, pkgs, ... }:
let
  compilers = [ "ghc884" "ghc8107" "ghc902" "ghc923" ];
  mkShellAlias = compiler: {
    name = "fhs-${compiler}";
    value = "nix-shell ${config.home.homeDirectory}/.fhs-${compiler}.nix";
  };

  buildHaskellFHS = compiler: {
    name = ".fhs-${compiler}.nix";
    value = {
      text = ''
        { pkgs ? import <nixpkgs> { } }:
        (pkgs.buildFHSUserEnv {
          name = "global";
          targetPkgs = pkgs: with pkgs; [
            coreutils
            gcc
            zlib.dev
            gmp.dev
            python
            haskell.compiler.${compiler}
            cabal-install
            stack
            haskellPackages.hoogle
            haskellPackages.implicit-hie
            stylish-haskell
            pre-commit
          ];
        }).env
      '';
    };
  };
in {
  programs.bash.shellAliases =
    builtins.listToAttrs (map mkShellAlias compilers);

  home.file = builtins.listToAttrs (map buildHaskellFHS compilers);
}
