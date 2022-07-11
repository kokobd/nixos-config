{ ... }: {
  config = {
    programs.git = {
      enable = true;
      userName = "kokobd";
      userEmail = "contact@zelinf.net";
      ignores = [ "*.swp" ".vscode/" ".idea/" ".venv/" ];
      extraConfig = {
        core = { editor = "vim"; };
        pull = { rebase = false; };
      };
    };
  };
}
