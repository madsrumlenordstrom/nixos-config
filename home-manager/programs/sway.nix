{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
  wayland.windowManager.sway = 
  let
    # Essentials
    wallpaper = "~/Pictures/wallpapers/the-glow-transparent.png";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    menu = "${pkgs.wofi}/bin/wofi -Imi --show drun|${pkgs.findutils}/bin/xargs ${pkgs.sway}/bin/swaymsg exec --";
    finder = "${pkgs.fd}/bin/fd --type file|${pkgs.wofi}/bin/wofi -Imi --show dmenu -M fuzzy|${pkgs.findutils}/bin/xargs -I {} ${pkgs.xdg-utils}/bin/xdg-open '{}'";
    fallback = "${config.colorScheme.palette.base02}";
    lock = "${pkgs.swaylock}/bin/swaylock -f -i ${wallpaper} -c ${fallback}";
    timeout = 900; # Seconds idle before going to sleep

    # Basic bindings
    modifier = "Mod4";
    left = "h";
    down = "j";
    up = "k";
    right = "l";
  in {
    enable = true;
    xwayland = false;
    config = {
      fonts = { names = [ "monospace" ]; size = 10.0; }; # TODO

      input = {
        # Keyboard layout
        "type:keyboard" = {
          xkb_layout = "us(mac),dk(mac),kr";
          xkb_options = "grp:alt_caps_toggle";
        };
        # Touchpad
        "type:touchpad" = {
          accel_profile = "adaptive";
          pointer_accel = "0.20";
          natural_scroll = "enabled";
          scroll_factor = "0.35";
          dwt = "disabled";
        };
        # Mouse
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.35";
        };
      };

      output = builtins.listToAttrs(map(m: {
        name = m.name;
        value = {
          mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}Hz";
          scale = toString m.scale;
          pos = "${toString m.x} ${toString m.y}";
          background = "${wallpaper} fill '#${fallback}'";
        };
      }) (config.monitors));

      startup = [
        { command = "${pkgs.gammastep}/bin/gammastep"; }
        # EASYEFFECTS TODO
        { command = ''
          ${pkgs.swayidle}/bin/swayidle -w \
          timeout 10 'if ${pkgs.procps}/bin/pgrep -x swaylock; then ${pkgs.sway}/bin/swaymsg "output * power off"; fi' \
          resume '${pkgs.sway}/bin/swaymsg "output * power on"' \
          timeout ${toString (timeout + 10)} '${pkgs.sway}/bin/swaymsg "output * power off"' \
          timeout ${toString timeout} '${lock}' \
          resume '${pkgs.sway}/bin/swaymsg "output * power on"'
        ''; }
      ];

      gaps = {
        inner = 6;
        outer = 0;
        left = 38; # fixes my broken screen :(
        smartGaps = false;
        smartBorders = "off";
      };

      window = {
        titlebar = false;
        hideEdgeBorders = "none";
        border = 1;
      };

      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

      keybindings = {
        # Essentials
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+q" = "kill";
        "${modifier}+d" = "exec ${menu}";
        "${modifier}+Shift+d" = "exec ${finder}";

        # Window focus
        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        # Window movement
        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        # Window layout
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+v" = "splitt";
        "${modifier}+w" = "layout toggle tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        # Workspace switching
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";

        # Move windows
        "${modifier}+Shift+1" = "move container to workspace number 1; workspace 1";
        "${modifier}+Shift+2" = "move container to workspace number 2; workspace 2";
        "${modifier}+Shift+3" = "move container to workspace number 3; workspace 3";
        "${modifier}+Shift+4" = "move container to workspace number 4; workspace 4";
        "${modifier}+Shift+5" = "move container to workspace number 5; workspace 5";
        "${modifier}+Shift+6" = "move container to workspace number 6; workspace 6";
        "${modifier}+Shift+7" = "move container to workspace number 7; workspace 7";
        "${modifier}+Shift+8" = "move container to workspace number 8; workspace 8";
        "${modifier}+Shift+9" = "move container to workspace number 9; workspace 9";

        # Scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+x" = "exec ${lock}";
        "${modifier}+c" = "reload";
        "${modifier}+Shift+e" = "exec ${pkgs.sway}/bin/swaymsg exit";

        "${modifier}+r" = "mode resize";


        # Brightness control
        "--locked XF86MonBrightnessDown " = "exec ~/.config/user-scripts/brightness-control.sh down";
        "--locked XF86MonBrightnessUp " = "exec ~/.config/user-scripts/brightness-control.sh up ";

        # Keyboard backlight control
        "--locked XF86KbdBrightnessDown " = "exec ~/.config/user-scripts/kb-brightness-control.sh down";
        "--locked XF86KbdBrightnessUp " = "exec ~/.config/user-scripts/kb-brightness-control.sh up";

        # Volume control
        "--locked XF86AudioMute " = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "--locked XF86AudioLowerVolume " = "exec ~/.config/user-scripts/volume-control.sh down";
        "--locked XF86AudioRaiseVolume " = "exec ~/.config/user-scripts/volume-control.sh up";

        # Media control
        "--locked XF86AudioPlay " = "exec ${pkgs.playerctl}/bin/playerctl --player playerctld play-pause";
        "--locked XF86AudioNext " = "exec ${pkgs.playerctl}/bin/playerctl --player playerctld next";
        "--locked XF86AudioPrev " = "exec ${pkgs.playerctl}/bin/playerctl --player playerctld previous";


        # Screenshots
        "${modifier}+Shift+XF86LaunchA" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save output";
        "${modifier}+Ctrl+Shift+XF86LaunchA" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output";
        # Selected area
        "${modifier}+Shift+XF86LaunchB" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save area";
        "${modifier}+Ctrl+Shift+XF86LaunchB" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
        # Specific window
        "${modifier}+Shift+XF86KbdBrightnessDown" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save window";
        "${modifier}+Ctrl+Shift+XF86KbdBrightnessDown" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy window";
      };

      floating = {
        # For window manipulation with pointer
        inherit modifier;

        # Make some windows float by default
        criteria = [
          { title = "(?:Open|Save) (?:File|Folder|As)"; }
        ];
      };

      modes = {
        resize = {
          "${left}" = "resize shrink width 10px";
          "${down}" = "resize grow height 10px";
          "${up}" = "resize shrink height 10px";
          "${right}" = "resize grow width 10px";

          "Left" = "resize shrink width 10px";
          "Down" = "resize grow height 10px";
          "Up" = "resize shrink height 10px";
          "Right" = "resize grow width 10px";

          # Return to default mode
          "Return" = "mode default";
          "Escape" = "mode default";
        };
      };

      # Cursor theme
      seat.seat0 = {
        xcursor_theme = "${config.cursor.name} ${toString config.cursor.size}";
      };

      # Colors
      colors = with config.colorScheme.palette; {
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
    extraConfig = ''
      # Allow switching between workspaces with left and right swipes
      bindgesture swipe:4:right workspace prev
      bindgesture swipe:4:left workspace next
      bindswitch --reload --locked lid:on exec ${lock}
    '';
  };
}
