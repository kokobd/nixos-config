{ config, pkgs, ... }: {
  programs.bash.shellAliases = {
    fhs = "nix-shell ${config.home.homeDirectory}/.fhs.nix";
  };

  home.file.".fhs.nix".text = ''
    { pkgs ? import <nixpkgs> { } }:
    (pkgs.buildFHSUserEnv {
      name = "hls-dev-env";
      targetPkgs = pkgs: with pkgs; [
        coreutils
        gcc
        zlib.dev
        gmp.dev
        python
        haskell.compiler.ghc923
        haskell.compiler.ghc902
        haskell.compiler.ghc8107
        cabal-install
        stack
        haskellPackages.hoogle
        stylish-haskell
        pre-commit
      ];
    }).env
  '';
}
