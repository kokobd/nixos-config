{ pkgs, ... }: {
  enable = true;
  userSettings = {
    "editor.fontSize" = 12;
    "editor.minimap.enabled" = false;
    "editor.tabSize" = 4;
    "editor.insertSpaces" = true;
    "editor.rulers" = [ 120 ];
    "workbench.startupEditor" = "none";
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
    "workbench.tree.indent" = 20;
    "files.autoSave" = "afterDelay";
    "nix.enableLanguageServer" = true;
    "[json]" = { "editor.tabSize" = 2; };
    "[nix]" = { "editor.tabSize" = 2; };
    "nix.formatterPath" = "nixpkgs-fmt";
  };
  extensions = with pkgs.vscode-extensions;
    [
      bbenoist.nix
      jnoortheen.nix-ide
      matklad.rust-analyzer
      haskell.haskell
      vscodevim.vim
      arrterian.nix-env-selector
      mhutchie.git-graph
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "vscode-leetcode";
      publisher = "LeetCode";
      version = "0.18.1";
      sha256 = "Ym9Gi9nL0b5dJq0yXbX2NvSW89jIr3UFBAjfGT9BExM=";
    }];
}
