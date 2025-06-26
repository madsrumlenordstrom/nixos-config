{ inputs, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.gtk;

  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
in
{
  config = mkIf cfg.enable {
    gtk = rec {
      font = {
        name = head config.fonts.fontconfig.defaultFonts.sansSerif;
        size = 12;
      };

      theme = {
        name = "${config.colorScheme.slug}";
        package = gtkThemeFromScheme { scheme = config.colorScheme; };
      };

      iconTheme = { inherit (config.icons) name package; };

      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = if config.colorScheme.variant == "dark" then "true" else "false";
        extraCss = /*css*/ ''
          * {
            border-radius: 0px; /* No round round corners allowed */
            box-shadow: none;
          }
        '';
      };
      gtk4.extraConfig = gtk3.extraConfig;
    };
  };
}
