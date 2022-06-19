{ pkgs, inputs, ... }: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.fonts = with pkgs;
    [
      nerdfonts
      # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];

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
    google-chrome
    nodejs
    git
    wget
    curl
    nixpkgs-fmt
    rnix-lsp
    keepassxc
    nixfmt
    postman
    htop
    gnome.gnome-tweaks
    screen
    lm_sensors
    nload
    cachix
    file
    openssl
    inputs.agenix.defaultPackage.x86_64-linux
    rage
    unzip
    zip
    gnupg
    pinentry
    lsof
    haskell.compiler.ghc8107
    haskell.compiler.ghc902
    haskell.compiler.ghc923
    haskell.compiler.ghcHEAD
    cabal-install
    stack
    pre-commit
    stylish-haskell
    haskellPackages.hoogle
  ];
}

