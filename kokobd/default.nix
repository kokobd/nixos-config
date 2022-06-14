{ pkgs, ... }: {
  programs = {
    bash.enable = true;
    vscode = import ./vscode.nix { inherit pkgs; };
    neovim = import ./neovim.nix { inherit pkgs; };
    git = {
      enable = true;
      userName = "kokobd";
      userEmail = "contact@zelinf.net";
      ignores = [ "*.swp" ".vscode/" ".idea/" ];
      extraConfig = {
        core = {
          editor = "vim";
        };
      };
    };
    ssh = {
      enable = true;
      serverAliveInterval = 20;
      serverAliveCountMax = 5;
      matchBlocks =
        let identityFile = "/home/kokobd/.ssh/id_rsa";
        in
        {
          tencent = {
            hostname = "119.91.200.28";
            user = "ubuntu";
            inherit identityFile;
          };
          home = {
            hostname = "119.91.200.28";
            user = "kokobd";
            port = 10022;
            inherit identityFile;
          };
        };
    };
  };
}
