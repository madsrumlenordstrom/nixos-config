{ lib, config, ... }:
with lib;
let
  cfg = config.fonts;
  font = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = ''
          Name of the font.
        '';
      };
      package = mkOption {
        type = types.package;
        description = ''
          Package of the font.
        '';
      };
    };
  };
in
{
  options.fonts = {
    size = mkOption {
      type = types.int;
      default = 10;
    };
    family = {
      serif = mkOption {
        type = font;
      };
      sans = mkOption {
        type = font;
      };
      monospace = mkOption {
        type = font;
      };
    };
  };

  config = {
    fonts.fontconfig.enable = true;
    home.packages = [ cfg.family.serif.package cfg.family.sans.package cfg.family.monospace.package ];
  };
}
