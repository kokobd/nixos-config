{ config, lib, pkgs, ... }:
let
  compilers = [ "ghc884" "ghc8107" "ghc902" "ghc923" ];
  mkNixShellCmd = compiler: "nix-shell ${config.home.homeDirectory}/.fhs-${compiler}.nix";
  mkShellAlias = compiler: {
    name = "fhs-${compiler}";
    value = mkNixShellCmd compiler;
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
in
{
  config = {
    programs.bash.shellAliases =
      builtins.listToAttrs (map mkShellAlias compilers);

    home.file = builtins.listToAttrs (map buildHaskellFHS compilers);

    services.openvscode-server.sessions =
      let mkOpenVsCodeSession = i: compiler:
        {
          name = "fhs-${compiler}";
          host = "0.0.0.0";
          port = toString (3000 + i);
          wrapper = inner: "${mkNixShellCmd compiler}";
        };
      in
      lib.imap1 mkOpenVsCodeSession compilers;
  };
}
