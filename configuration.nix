# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "kokobd-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      extra-substituters =
        [ "https://cache.iog.io" "https://nix-community.cachix.org" ];
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kokobd = {
    isNormalUser = true;
    description = "Kobayashi";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDApPBhZ2SrXvpfe9ARU7AWJrLNFl3w1BADTXT6IZaPe+glU7MjyUO0P1unpL+6G1Vgk+EYtfBsjRUxoVp7WxxunIhlhh7XH8Vd8rqCsdF9zqaahA+UfwgsximUxNmDDeLsEr/4yixuINjf88i5Pd0aG4aruXPBuV9K1PXooPzffPgnxu5d6r0PdDRhpoGNw4sp3GXX4gK36VnGlKaLA1mLDIr19RRYkcThl+9UgdJ2XnVsZ81fV4a5fFRo+6HIzD41fNKbSw97N1TCe7rwcvf7UubRq+1AFA29wh2ENSemkATx6aixKaNLF8W9MvJ1lK1qrmqvcyt1UmDpmVN3Vl/xuxTh/i97Llw/AJpb3Avs6DxRVqW+/DA9nfBNDI2vglpIN545wXDRg9smQOv7O8ixvjAgICkH5edtaMwILM9HuA3If0xBGj+cgXk/Z5PVU8fZA7cOdQYyQnfYdvQLyJy2oZTdwMXDf1IHs33zAvgsQcmpLVx0XNsFa5mraYinhlPF5VAPWjzzXSt1qW9j+a1+sKZ0AtuEkTdZjwCdaaI/cLg7c0xlcmITAQ60r/lflQx6GDFQkWj1rpKWrEsWuxfzgHRU07W2JpT9utVqHMkPXOakNmRzSYM/I21YkGS4MAyNbjFnZNLakR12dPbPwnUILhZ1mOKLjRCtv0p7+VS4iQ== isumi@isumi-mipro"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJxg+DsNaapEi5sHalphYKkTOxRILlKbnViCesQ1wvs"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    haskell.compiler.ghc922
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
  ];

  fonts.fonts = with pkgs;
    [
      nerdfonts
      # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.vim.defaultEditor = true;
  programs.gnupg.agent.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  services.autossh.sessions = [{
    name = "public";
    user = "kokobd";
    monitoringPort = 0;
    extraArguments = "-N -R 10022:localhost:22 tencent";
  }];

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  age = import ./age.nix { lib = pkgs.lib; };
}
