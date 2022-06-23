{ pkgs, ... }: {
  imports = [
    ./ssh.nix
    ./fhs.nix
    ./git.nix
    ./vscode.nix
    ./openvscode-server.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [ openvscode-server ];
  programs.bash.enable = true;
}
