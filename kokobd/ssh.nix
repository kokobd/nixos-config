{ ... }:

{
  programs = {
    ssh = {
      enable = true;
      serverAliveInterval = 10;
      serverAliveCountMax = 10;
      matchBlocks = let identityFile = "/home/kokobd/.ssh/id_ed25519";
      in {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          inherit identityFile;
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
}
