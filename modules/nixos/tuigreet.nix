{
  lib,
  config,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.tuigreet;
in
{
  options.tuigreet  = {
    enable = mkEnableOption "Tuigreet display manager";

    package = mkPackageOption pkgs [ "greetd" "tuigreet" ] { example = "pkgs.greetd.tuigreet"; };

    settings = { 
      args = mkOption {
        type = types.listOf types.str;
        default = [
          "--user-menu"
          "--remember"
          "--time"
          "--time-format '%Y-%m-%d %H:%M'"
          "--asterisks"
          "--cmd sway"
        ];
        description = ''
          Arguments to pass to the tuigreet binary.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # Greeter before compositor
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${cfg.package}/bin/tuigreet ${concatStringsSep " " cfg.settings.args}";
        user = "greeter";
      };
    };
  };
}
