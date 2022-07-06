{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.openvscode-server;
  package = pkgs.openvscode-server;
  vscodePname = config.programs.vscode.package.pname;

  configDir = {
    "vscode" = "Code";
    "vscode-insiders" = "Code - Insiders";
    "vscodium" = "VSCodium";
  }.${vscodePname};
  userDir = "${config.xdg.configHome}/${configDir}/User";
  configFilePath = "${userDir}/settings.json";
  tasksFilePath = "${userDir}/tasks.json";
  keybindingsFilePath = "${userDir}/keybindings.json";

  extensionDir = {
    "vscode" = "vscode";
    "vscode-insiders" = "vscode-insiders";
    "vscodium" = "vscode-oss";
  }.${vscodePname};
  extensionPath = ".${extensionDir}/extensions";
in
{
  options = {
    services.openvscode-server = {
      enable = mkEnableOption "Open VSCode Server";

      shell = mkOption {
        type = types.str;
        default = "bash";
        description = ''
          Specify which shell program openvscode-server should use.
        '';
      };

      host = mkOption {
        type = types.str;
        default = "localhost";
        description = ''
          The host name or IP address the server should listen to. If not set, defaults to 'localhost'
        '';
      };

      port = mkOption {
        type = types.str;
        default = 3000;
        description = ''
          The port the server should listen to. If 0 is passed a random free port is picked. If a range in the
          format num-num is passed, a free port from the range (end inclusive) is selected.
        '';
      };

      rev = mkOption {
        type = types.str;
        description = ''
          Revision for nix-shell
        '';
      };

      packages = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "List of packages enabled in openvscode-server";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      (hm.assertions.assertPlatform "services.openvscode-server" pkgs
        platforms.linux)
    ];

    programs.${cfg.shell}.enable = true;

    systemd.user.services.openvscode-server = {
      Unit = { Description = "Open VSCode Server"; };

      Install.WantedBy = [ "default.target" ];

      Service =
        let
          wrapper = pkgs.writeScriptBin "openvscode-server-wrapper" ''
            #!/usr/bin/env nix-shell 
            #!nix-shell -i ${cfg.shell} -p ${strings.concatStringsSep " " cfg.packages}
            #! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/${cfg.rev}.tar.gz

            ${pkgs.nodejs-14_x}/bin/node ${pkgs.openvscode-server}/out/server-main.js \
              --port ${cfg.port} \
              --host ${cfg.host} \
              --without-connection-token \
              --server-data-dir=${config.home.homeDirectory}/.openvscode-server
          '';
        in
        {
          ExecStart = "${wrapper}/bin/openvscode-server-wrapper";
          Restart = "on-failure";
        };
    };

    home.file = {
      ".openvscode-server/data/Machine/settings.json".source =
        config.home.file."${configFilePath}".source;
      ".openvscode-server/extensions".source =
        config.home.file."${extensionPath}".source;
    };
  };
}

