{ pkgs, ... }: {
  imports = [ ./openvscode-server.nix ./ssh.nix ./fhs.nix ./vscode.nix ];

  home.packages = with pkgs; [ openvscode-server pre-commit stylish-haskell ];
  programs = {
    bash.enable = true;
    neovim = import ./neovim.nix { inherit pkgs; };
    git = {
      enable = true;
      userName = "kokobd";
      userEmail = "contact@zelinf.net";
      ignores = [ "*.swp" ".vscode/" ".idea/" ];
      extraConfig = { core = { editor = "vim"; }; };
    };
  };
}
