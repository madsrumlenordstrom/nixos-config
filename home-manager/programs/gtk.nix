{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
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
      name = if config.colorScheme.variant == "dark" then "Papirus-Dark" else "Papirus-Light";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      # name = "capitaine-cursors-white";
      name = if config.colorScheme.variant == "dark" then "capitaine-cursors-white" else "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 32;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = if config.colorScheme.variant == "dark" then "true" else "false";
      };
      extraCss = /*css*/ ''
        * {
          border-radius: 0px;
          box-shadow: none;
        }
      '';
    };
    gtk4.extraConfig = gtk3.extraConfig;
  };
  home.packages = [ pkgs.dconf ];  # Fixes bug https://github.com/nix-community/home-manager/issues/3113
}
