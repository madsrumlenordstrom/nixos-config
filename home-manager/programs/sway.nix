
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    xwayland = false;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      fonts = { names = [ "monospace" ]; size = 10.0; };

      input = {
        "type:keyboards" = {
          xkb_layout = "us,dk,kr";
          xkb_options = "grp:alt_caps_toggle";
        };
        "type:touchpad" = {
          accel_profile = "adaptive";
          pointer_accel = "0.20";
          natural_scroll = "enabled";
          scroll_factor = "0.35";
          dwt = "disabled";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.35";
        };
      };

      output = {
        "*".bg = "~/Pictures/wallpapers/the-glow-transparent.png fill #4c4f69";
        eDP-1 = {
          scale = "2";
        };
      };

      startup = [
        { command = "gammastep --gapplication-service"; }
        { command = ''
          ${pkgs.swayidle}/bin/swayidle -w \
          timeout 10 'if pgrep -x swaylock; then swaymsg "output * power off"; fi' \
          resume 'swaymsg "output * power on"' \
          timeout 600 ${pkgs.swaylock}/bin/swaylock -f -i ~/Pictures/wallpapers/the-glow-transparent.png -c \#4c4f69 \
          timeout 610 'swaymsg "output * power off"' \
          resume 'swaymsg "output * power on"'
        ''; }
      ];

      gaps = {
        inner = 6;
        outer = 0;
        left = 30; # fixes my broken screen
        smartGaps = false;
        smartBorders = "off";
      };

      window = {
        hideEdgeBorders = "none";
        border = 1;
      };

      bars = [{
        command = "${pkgs.waybar}/bin/waybar";
      }];

      # keybindings = let 
      #   c = config.wayland.windowManager.sway.config;
      #   in {
      #     "${c.modifier}+Shift+d" = " exec ${pkgs.fd}/bin/fd --type file |${pkgs.wofi}/bin/wofi -Imi --show dmenu -M fuzzy |${pkgs.findutils}/bin/xargs -I {} ${pkgs.xdg-utils}/bin/xdg-open '{}'";
      #     "${c.modifier}+v" = "splitt";
      #   };
      colors = with config.colorScheme.colors; {
        focused = {
          border = "#${base07}";
          background = "#${base00}";
          text = "#${base05}";
          indicator = "#${base06}";
          childBorder = "#${base04}";
        };
        focusedInactive = {
          border = "#${base04}";
          background = "#${base00}";
          text = "#${base05}";
          indicator = "#${base06}";
          childBorder = "#${base01}";
        };
        unfocused = {
          border = "#${base04}";
          background = "#${base00}";
          text = "#${base05}";
          indicator = "#${base06}";
          childBorder = "#${base01}";
        };
      };
    };
  };
}
