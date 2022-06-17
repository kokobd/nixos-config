{ pkgs, ... }: {
  imports = [ ./openvscode-server.nix ];

  home.packages = with pkgs; [ neovide ];
  programs = {
    bash.enable = true;
    vscode = import ./vscode.nix { inherit pkgs; };
    neovim = import ./neovim.nix { inherit pkgs; };
    git = {
      enable = true;
      userName = "kokobd";
      userEmail = "contact@zelinf.net";
      ignores = [ "*.swp" ".vscode/" ".idea/" ];
      extraConfig = { core = { editor = "vim"; }; };
    };
    ssh = {
      enable = true;
      serverAliveInterval = 10;
      serverAliveCountMax = 10;
      matchBlocks = let identityFile = "/home/kokobd/.ssh/id_rsa";
      in {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "/home/kokobd/.ssh/id_ed25519";
        };
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
        home-gateway = {
          hostname = "192.168.31.2";
          user = "pi";
          inherit identityFile;
        };
      };
    };
  };

  services.openvscode-server = {
    enable = true;
    host = "0.0.0.0";
    port = "3000";
  };
}
