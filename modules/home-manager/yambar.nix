{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.yambar;

  yamlFormat = pkgs.formats.yaml { };

in {
  meta.maintainers = [ ];

  options.programs.yambar = {
    enable = mkEnableOption "yambar";

    package = mkOption {
      type = types.package;
      default = pkgs.yambar;
      defaultText = literalExpression "pkgs.yambar";
      description = "The yambar package to install.";
    };



    settings = mkOption {
      type = yamlFormat.type;
      default = { };

      example = literalExpression ''
        {
          bar = {
            location = "top";
            height = 26;
            background = "00000066";
            right = [
              {
                clock.content = [
                  {
                    string.text = "{time}";
                  }
                ];
              }
            ];
          };
        }
      '';

      description = ''
        Configuration written to
        <filename>$XDG_CONFIG_HOME/yambar/config.yml</filename>.
        See
        <citerefentry>
         <refentrytitle>yambar</refentrytitle>
         <manvolnum>5</manvolnum>
        </citerefentry>
        for options.
      '';
    };

    systemd.enable = mkEnableOption "yambar systemd integration";

    systemd.target = mkOption {
      type = types.str;
      default = "graphical-session.target";
      example = "sway-session.target";
      description = ''
        The systemd target that will automatically start the yambar service.

        When setting this value to `"sway-session.target"`,
        make sure to also enable {option}`wayland.windowManager.sway.systemd.enable`,
        otherwise the service may never be started.
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [ (hm.assertions.assertPlatform "programs.yambar" pkgs platforms.linux) ];

    home.packages = [ cfg.package ];

    xdg.configFile."yambar/config.yml" = mkIf (cfg.settings != { }) {
      source = yamlFormat.generate "yambar-config" cfg.settings;
    };

    systemd.user.services.yambar = mkIf cfg.systemd.enable {
      Unit = {
        Description = "Modular status panel for X11 and Wayland";
        Documentation = "man:yambar";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" "pipewire.service" ];
      };

      Service = {
        ExecStart = "${cfg.package}/bin/yambar";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        Restart = "on-failure";
        RestartSec = 3;
        KillMode = "mixed";
      };

      Install = { WantedBy = [ cfg.systemd.target ]; };
    };
  };
}
