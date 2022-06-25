{ pkgs, inputs, ... }:

{
  imports = [ ./gpg.nix ./secrets.nix ./users.nix ./nixtool.nix ];

  system.stateVersion = "22.05";

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.utf8";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    (vim_configurable.customize {
      name = "vim";
      vimrcConfig.customRC = ''
                  filetype plugin indent on
                  set expandtab
                  set tabstop=2
                  set nu
                  set softtabstop=2
                  set shiftwidth=2
                  set autoindent
        	'';
    })

    nodejs
    git
    wget
    curl
    nixpkgs-fmt
    rnix-lsp
    nixfmt
    htop
    screen
    lm_sensors
    nload
    cachix
    file
    openssl
    inputs.agenix.defaultPackage.${pkgs.system}
    rage
    unzip
    zip
    gnupg
    pinentry
    lsof
    nix-prefetch-git
    pre-commit
    stylish-haskell
    sysbench
    stress-ng
  ];

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  programs.vim.defaultEditor = true;

  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
    };
    autossh.sessions = [{
      name = "public";
      user = "kokobd";
      monitoringPort = 0;
      extraArguments = "-N -R 10022:localhost:22 tencent";
    }];
  };
}
