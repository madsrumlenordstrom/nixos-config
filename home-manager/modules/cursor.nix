{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.cursor;
in
{
  options.cursor = {
    enable = mkEnableOption "Cursor theme module";

    package = mkPackageOption pkgs "cursor" { example = "pkgs.capitaine-cursors"; };

    name = mkOption {
      type = types.str;
      example = "capitaine-cursors-white";
      description = ''
        Name of the curcor theme.
      '';
    };

    path = mkOption {
      type = types.path;
      apply = toString;
      example = "${cfg.package}/share/icons/${cfg.name}";
      description = ''
        Path to the cursor theme.
      '';
    };

    size = mkOption {
      type = types.int;
      default = 32;
      description = ''
        Size of the cursor.
      '';
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # Dynamically set the `path` if it's not explicitly configured by the user
    cursor.path = mkDefault "${cfg.package}/share/icons/${cfg.name}";
  };
}
