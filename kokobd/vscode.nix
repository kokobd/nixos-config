{ pkgs, ... }: {
  services.openvscode-server = {
    enable = true;
    host = "0.0.0.0";
    port = "3000";
  };

  programs.bash.shellAliases = {
    "code-server" =
      "openvscode-server --without-connection-token --host 0.0.0.0";
  };

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    userSettings = {
      "update.mode" = "none";
      "extensions.autoUpdate" = false;
      "editor.fontSize" = 12;
      "editor.minimap.enabled" = false;
      "editor.tabSize" = 4;
      "editor.insertSpaces" = true;
      "editor.rulers" = [ 120 ];
      "editor.smoothScrolling" = true;
      "workbench.startupEditor" = "none";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "workbench.tree.indent" = 20;
      "files.autoSave" = "afterDelay";
      "nix.enableLanguageServer" = true;
      "[json]" = { "editor.tabSize" = 2; };
      "[nix]" = { "editor.tabSize" = 2; };
      "nix.formatterPath" = "nixfmt";
      "workbench.colorTheme" = "Default Dark+";
      "leetcode.workspaceFolder" =
        "/home/kokobd/work/github.com/kokobd/leetcode-rs/src";
      "leetcode.defaultLanguage" = "rust";
      "haskell.plugin.ghcide-completions.config.snippetsOn" = false;
      "vim.handleKeys" = { "<C-f>" = false; };

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
