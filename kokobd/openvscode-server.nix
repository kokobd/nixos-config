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
in {
  options = {
    services.openvscode-server = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
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

          nodeCommand = mkOption {
            type = types.str;
            default = "${pkgs.nodejs-14_x}/bin/node";
          };
        };
      });
    };
  };

  config = mkIf (cfg != { }) {
    assertions = [
      (hm.assertions.assertPlatform "services.openvscode-server" pkgs
        platforms.linux)
    ];

    programs.bash.enable = true;

    systemd.user.services = let
      buildService = name: cfg:
        nameValuePair ("openvscode-server-" + name) {
          Unit = { Description = "Open VSCode Server"; };

          Install.WantedBy = [ "default.target" ];

          Service = let
            wrapper = pkgs.writeScriptBin "openvscode-server-wrapper" ''
              #!${pkgs.bash}/bin/bash

              ${cfg.nodeCommand} "${pkgs.openvscode-server}/out/server-main.js" \
                --port ${cfg.port} \
                --host ${cfg.host} \
                --without-connection-token \
                --server-data-dir=${config.home.homeDirectory}/.openvscode-server
            '';
          in {
            ExecStart = "${wrapper}/bin/openvscode-server-wrapper";
            Restart = "on-failure";
          };
        };
    in mapAttrs' buildService cfg;

    home.file = {
      ".openvscode-server/data/Machine/settings.json".source =
        config.home.file."${configFilePath}".source;
      ".openvscode-server/extensions".source =
        config.home.file."${extensionPath}".source;
    };
  };
}
