{ inputs, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.i18n;
in
{
  options.i18n.enable = mkEnableOption "Internationalization and localization";

  config = mkIf cfg.enable {
    i18n = { 
      defaultLocale = "en_DK.UTF-8";
      supportedLocales = [
        "C.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
        "da_DK.UTF-8/UTF-8"
        "en_DK.UTF-8/UTF-8"
      ];
    };
  };
}
