{ config, pkgs, ... }:

{
  system.userActivationScripts.installGpgKey = {
    text = ''
      ${pkgs.gnupg}/bin/gpg --import /home/kokobd/Documents/private.gpg
    '';
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
