{ ... }: {
  config = {
    programs.git = {
      enable = true;
      userName = "kokobd";
      userEmail = "contact@zelinf.net";
      ignores = [ "*.swp" ".vscode/" ".idea/" ];
      extraConfig = { core = { editor = "vim"; }; };
    };
  };
}
