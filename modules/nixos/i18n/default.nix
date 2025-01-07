{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.i18n;
in
{
  options.i18n.enable = mkEnableOption "Internationalization and localization";

  config = mkIf cfg.enable {
    i18n = { 
      defaultLocale = "en_US.UTF-8";
      # Use ISO 8601 date format
      extraLocaleSettings.LC_TIME = "en_DK.UTF-8";
      supportedLocales = lib.mkDefault [
        "en_US.UTF-8/UTF-8"
        "da_DK.UTF-8/UTF-8"
      ];
    };
  };
}
