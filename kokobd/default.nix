{ pkgs, ... }: {
  imports = [ ./openvscode-server.nix ./ssh.nix ];

  home.packages = with pkgs; [
    neovide
  ];
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
  };

  services.openvscode-server = {
    enable = true;
    host = "0.0.0.0";
    port = "3000";
  };
}
