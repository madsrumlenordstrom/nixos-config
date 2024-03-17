{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./fuzzel.nix        # Menu
    ./dunst.nix         # Notification daemon (systemd service)
    ./gammastep.nix     # Color temperature adjuster (systemd service)
    ./swaylock.nix      # Screen locker (systemd service)
    ./swayidle.nix      # Inactivity manager (systemd service)
    ./yambar.nix        # Status bar (systemd service)
  ];

  # Playerctl for controlling media
  services.playerctld.enable = lib.mkIf config.wayland.windowManager.sway.enable true;

  # Sway config
  wayland.windowManager.sway = 
  let
    # Essentials
    swaymsg = "${config.wayland.windowManager.sway.package}/bin/swaymsg";
    swaylock = "${config.programs.swaylock.package}/bin/swaylock";
    terminal = "${config.programs.alacritty.package}/bin/alacritty"; # TODO find modular way to do this
    menu = "${config.programs.fuzzel.package}/bin/fuzzel";
    finder = "${pkgs.fd}/bin/fd --type file|${menu} --dmenu|${pkgs.findutils}/bin/xargs -I {} ${pkgs.xdg-utils}/bin/xdg-open '{}'";
    playerctl = "${config.services.playerctld.package}/bin/playerctl";
    grimshot = "${pkgs.sway-contrib.grimshot}/bin/grimshot";

    # Wallpaper
    wallpaper = "~/Pictures/wallpapers/the-glow-transparent.png"; # TODO find better way to do this
    fallback = "${config.colorScheme.palette.base02}"; # Fallback color for wallpaper

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
        # EASYEFFECTS TODO
      ];

      gaps = {
        inner = 6;
        outer = 0;
        smartGaps = false;
        smartBorders = "off";
      };

      window = {
        titlebar = false;
        hideEdgeBorders = "none";
        border = 1;
      };

      # Hides default swaybar
      bars = [ ];

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

        "${modifier}+x" = "exec ${swaylock}";
        "${modifier}+c" = "reload";
        "${modifier}+Shift+e" = "exec ${pkgs.systemd}/bin/systemctl --user stop sway-session.target | ${swaymsg} exit";

        "${modifier}+r" = "mode resize";


        # Brightness control
        "--locked XF86MonBrightnessDown " = "exec ${pkgs.brightness-control}/bin/brightness-control down";
        "--locked XF86MonBrightnessUp " = "exec ${pkgs.brightness-control}/bin/brightness-control up ";

        # Keyboard backlight control
        "--locked XF86KbdBrightnessDown " = "exec ${pkgs.kb-brightness-control}/bin/kb-brightness-control down";
        "--locked XF86KbdBrightnessUp " = "exec ${pkgs.kb-brightness-control}/bin/kb-brightness-control up";

        # Volume control
        "--locked XF86AudioMute " = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "--locked XF86AudioLowerVolume " = "exec ${pkgs.volume-control}/bin/volume-control down";
        "--locked XF86AudioRaiseVolume " = "exec ${pkgs.volume-control}/bin/volume-control up";

        # Media control
        "--locked XF86AudioPlay " = "exec ${playerctl} --player playerctld play-pause";
        "--locked XF86AudioNext " = "exec ${playerctl} --player playerctld next";
        "--locked XF86AudioPrev " = "exec ${playerctl} --player playerctld previous";

        # Screenshots
        "${modifier}+Shift+XF86LaunchA" = "exec ${grimshot} save output";
        "${modifier}+Ctrl+Shift+XF86LaunchA" = "exec ${grimshot} copy output";
        # Selected area
        "${modifier}+Shift+XF86LaunchB" = "exec ${grimshot} save area";
        "${modifier}+Ctrl+Shift+XF86LaunchB" = "exec ${grimshot} copy area";
        # Specific window
        "${modifier}+Shift+XF86KbdBrightnessDown" = "exec ${grimshot} save window";
        "${modifier}+Ctrl+Shift+XF86KbdBrightnessDown" = "exec ${grimshot} copy window";
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
      seat.seat0.xcursor_theme = "${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}";

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
          indicator = "#${base04}";
          childBorder = "#${base01}";
        };
        unfocused = {
          border = "#${base04}";
          background = "#${base00}";
          text = "#${base05}";
          indicator = "#${base04}";
          childBorder = "#${base01}";
        };
      };
    };

    extraSessionCommands = /*shell*/ ''
      # Make electron apps work on wayland
      export NIXOS_OZONE_WL=1
    '';

    extraConfig = ''
      # Allow switching between workspaces with left and right swipes
      bindgesture swipe:4:right workspace prev
      bindgesture swipe:4:left workspace next
      bindswitch --reload --locked lid:on exec ${swaylock}
    '';
  };
}
