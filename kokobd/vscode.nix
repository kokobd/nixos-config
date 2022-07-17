{ pkgs, ... }:
let
  fhsEnvArgs = {
    name = "fhs-global";
    targetPkgs = pkgs:
      with pkgs; [
        coreutils
        binutils
        gnumake
        nix
        git
        vim
        neovim
        openssh
        which
        bash
        gcc
        zlib.dev
        gmp.dev
        ncurses.dev
        python
        python310
        nodejs-14_x
        spdlog
        miniserve
        cabal-install
        stack
        xclip
        haskellPackages.hoogle
        haskellPackages.implicit-hie
        stylish-haskell
        pre-commit
        haskell.compiler.ghc923
        haskell.compiler.ghc902
        haskell.compiler.ghc8107
        haskell.compiler.ghc884
        haskell.compiler.ghc865Binary
        setghc
      ];
    runScript = "node";
    profile = "export PATH=~/.cabal/bin:~/.local/bin:$PATH";
  };

  fhsEnvForVSCode = pkgs.buildFHSUserEnv fhsEnvArgs;
  fhsEnvForShell = pkgs.buildFHSUserEnv (fhsEnvArgs // { runScript = "bash"; });

  setghc = pkgs.writeScriptBin "setghc" ''
    #!${pkgs.bash}/bin/bash

    set -e
    rm ~/.local/bin/ghc
    ln -s /usr/bin/ghc-$1 ~/.local/bin/ghc
  '';
in {
  services.openvscode-server.default = {
    host = "localhost";
    port = "3000";
  };

  services.openvscode-server.fhs = {
    host = "localhost";
    port = "3001";

    nodeCommand = "${fhsEnvForVSCode}/bin/fhs-global";
  };

  home.packages = [ fhsEnvForShell ];

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    userSettings = {
      "update.mode" = "none";
      "extensions.autoUpdate" = false;
      "editor.fontSize" = 12;
      "editor.minimap.enabled" = false;
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.rulers" = [ 120 ];
      "editor.smoothScrolling" = true;
      "workbench.startupEditor" = "none";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "workbench.tree.indent" = 20;
      "files.autoSave" = "afterDelay";
      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "nixfmt";
      "workbench.colorTheme" = "Default Dark+";
      "leetcode.workspaceFolder" =
        "/home/kokobd/work/github.com/kokobd/leetcode-rs/src";
      "leetcode.defaultLanguage" = "rust";
      "haskell.plugin.ghcide-completions.config.snippetsOn" = false;
      "vim.handleKeys" = { "<C-f>" = false; };
      "editor.suggest.snippetsPreventQuickSuggestions" = false;
      "haskell.formattingProvider" = "stylish-haskell";

      "typescript.tsc.autoDetect" = "off";
    };
    extensions = with pkgs.vscode-extensions;
      [
        eamodio.gitlens
        bbenoist.nix
        jnoortheen.nix-ide
        matklad.rust-analyzer
        haskell.haskell
        justusadam.language-haskell
        vscodevim.vim
        arrterian.nix-env-selector
        mhutchie.git-graph
        editorconfig.editorconfig
        usernamehw.errorlens
        coolbear.systemd-unit-file
        github.vscode-pull-request-github
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-leetcode";
          publisher = "LeetCode";
          version = "0.18.1";
          sha256 = "Ym9Gi9nL0b5dJq0yXbX2NvSW89jIr3UFBAjfGT9BExM=";
        }
        {
          name = "resourcemonitor";
          publisher = "mutantdino";
          version = "1.0.7";
          sha256 = "zxh1sre+eakKSV0dCXUwtE/NNFKy6MhhP6AzHNBQuA0=";
        }
      ];
  };
}
