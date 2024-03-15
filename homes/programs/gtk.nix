{ inputs, outputs, lib, config, pkgs, ... }:
let
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
in
{
  gtk = rec {
    enable = true;
    # font = { TODO
    #   name = config.fontProfiles.regular.family;
    #   size = 12;
    # };
    theme = {
      name = "${config.colorScheme.slug}";
      package = gtkThemeFromScheme { scheme = config.colorScheme; };
    };
    iconTheme = {
      inherit (config.icons) name package;
    };
    cursorTheme = {
      inherit (config.cursor) name package size;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = if config.colorScheme.variant == "dark" then "true" else "false";
      };
      extraCss = /*css*/ ''
        * {
          border-radius: 0px; /* No round round corners allowed */
          box-shadow: none;
        }
      '';
    };
    gtk4.extraConfig = gtk3.extraConfig;
  };
  home.packages = [ pkgs.dconf ];  # Fixes bug https://github.com/nix-community/home-manager/issues/3113
}
