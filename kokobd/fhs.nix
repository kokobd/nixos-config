{ config, pkgs, ... }:

{
  programs.bash.shellAliases.fhs = "nix-shell ${config.home.homeDirectory}/fhs.nix";

  home.file = {
    "fhs.nix" = {
      text = ''
        { pkgs ? import <nixpkgs> { } }:
        (pkgs.buildFHSUserEnv {
          name = "global";
          targetPkgs = pkgs: with pkgs; [
            coreutils
            binutils
            gcc
            zlib.dev
            gmp.dev
            ncurses.dev
            python
            cabal-install
            stack
            haskellPackages.hoogle
            haskellPackages.implicit-hie
            stylish-haskell
            pre-commit
            haskell.compiler.ghc923
            haskell.compiler.ghc902
            haskell.compiler.ghc8107
            haskell.compiler.ghc884
            haskell.compiler.ghc865Binary
          ];
          profile = "export PATH=~/.cabal/bin:~/.local/bin:$PATH";
        }).env
      '';
    };
  };
}
