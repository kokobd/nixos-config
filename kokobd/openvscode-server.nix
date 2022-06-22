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
    services.openvscode-server.sessions = mkOption {
      default = [ ];
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            description = "Name of openvscode-server session";
          };

          shell = mkOption {
            type = types.str;
            default = "bash";
            description = ''
              Specify which shell program openvscode-server should use.
            '';
          };

          fhsEnv = mkOption {
            type = types.functionTo types.str;
            default = inner: inner;
            description = "wraps the actual command used to start openvscode-server";
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
        };
      });
    };
  };

  config = mkIf (cfg.sessions != [ ]) {
    assertions = [
      (hm.assertions.assertPlatform "services.openvscode-server" pkgs
        platforms.linux)
    ];

    home.file = {
      ".openvscode-server/data/Machine/settings.json".source =
        config.home.file."${configFilePath}".source;
      ".openvscode-server/extensions".source =
        config.home.file."${extensionPath}".source;
    };

    # programs.${cfg.shell}.enable = true;

    systemd.user.services =
      let mkService = session: {
        name = "openvscode-server-${session.name}";
        value = {
          Unit = { Description = "Open VSCode Server. Session: ${session.name}"; };

          Install.WantedBy = [ "default.target" ];

          Service =
            let
              wrappedCommand = session.wrapper "${pkgs.nodejs-14_x}/bin/node ${pkgs.openvscode-server}/out/server-main.js"
                + " --without-connection-token"
                + " --host ${session.host}"
                + " --port ${session.port}";
              shebang = ''#!${pkgs."${session.shell}"}/bin/${session.shell}'';
              wrapper = pkgs.writeScriptBin "wrapper" ''
                ${shebang}
                set -ex
                echo 'preparing to start openvscode-server'
                ${wrappedCommand}
              '';
            in
            {
              ExecStart = "${wrapper}/bin/wrapper";
              Restart = "on-failure";
            };
        };
      };
      in
      builtins.listToAttrs (map mkService cfg.sessions);
  };
}

