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
            identityFile = identityFile;
          };
        };
    };
  };
}
