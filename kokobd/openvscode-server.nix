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

  extensionDir = {
    "vscode" = "vscode";
    "vscode-insiders" = "vscode-insiders";
    "vscodium" = "vscode-oss";
  }.${vscodePname};

  userDir =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "Library/Application Support/${configDir}/User"
    else
      "${config.xdg.configHome}/${configDir}/User";

  configFilePath = "${userDir}/settings.json";
  tasksFilePath = "${userDir}/tasks.json";
  keybindingsFilePath = "${userDir}/keybindings.json";

  extensionPath = ".${extensionDir}/extensions";
in
{
  options = {
    services.openvscode-server = {
      enable = mkEnableOption "Open VSCode Server";

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
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.openvscode-server = {
      Unit = { Description = "Open VSCode Server"; };

      Install.WantedBy = [ "default.target" ];

      Service =
        let
          wrapper = pkgs.writeScriptBin "wrapper" ''
            #!${pkgs.bash}/bin/bash

            "${pkgs.nodejs-14_x}/bin/node" "${pkgs.openvscode-server}/out/server-main.js" \
              --port ${cfg.port} \
              --host ${cfg.host} \
              --without-connection-token \
              --server-data-dir=${config.home.homeDirectory}/.openvscode-server
          '';
        in
        {
          Environment = [ "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin" ];
          ExecStart = "${wrapper}/bin/wrapper";
          Restart = "on-failure";
        };
    };

    home.file = {
      ".openvscode-server/data/Machine/settings.json".source = config.home.file."${configFilePath}".source;
      ".openvscode-server/extensions".source = config.home.file."${extensionPath}".source;
    };
  };
}

