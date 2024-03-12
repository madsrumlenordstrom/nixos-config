{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.fuzzel = {
    enable = true;

    settings = let
      boolToYN = b: if b then "yes" else "no";
    in {
      main = {
        font = "monospace:pixelsize=42";
        dpi-aware = boolToYN true;
        icon-theme = config.icons.name;
        icons-enabled = boolToYN true;
        show-actions = boolToYN false;
        terminal = config.home.sessionVariables.TERM;
        width = 35;
        horizontal-pad = 16;
        vertical-pad = 8;
        lines = 10;
      };

      colors = with config.colorScheme.palette; {
        background = "${base00}ff";
        text = "${base05}ff";
        match = "${base08}ff";
        selection = "${base04}ff";
        selection-text = "${base05}ff";
        selection-match = "${base08}ff";
        border = "${base04}ff";
      };

      border = {
        width = 2;
        radius = 0;
      };
    };
  };
}
