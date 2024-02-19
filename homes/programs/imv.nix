{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.imv = {
    enable = true;
    settings = {
      options = with config.colorScheme.palette; {
        width = 640;
        height = 400;
        background = "${base00}";
        overlay_font = "monospace:10";
        overlay_text_color = "${base05}";
        overlay_background_color = "${base00}";
        overlay_background_alpha = "ff";
        overlay_position_bottom = true;
      };
    };
  };
}
