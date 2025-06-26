{ inputs, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.imv;
in
{
  config = mkIf cfg.enable {
    programs.imv = {
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
  };
}
