{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # For notification binaries
  home.packages = [ pkgs.libnotify ];

  # Dunst configuration
  services.dunst = {
    global = {
      follow = "mouse";
      width = 220;
      height = 300;
      origin = "top-right";
      offset = "6x6";
      notification_limit = 0;
      progress_bar = true;
      progress_bar_height = 10;
      progress_bar_frame_width = 1;
      progress_bar_min_width = 220;
      progress_bar_max_width = 300;
      separator_height = 1;
      padding = 8;
      horizontal_padding = 8;
      text_icon_padding = 0;
      frame_width = 1;
      gap_size = 0;
      separator_color = "frame";
      font = "monospace 10"; # TODO
      markup = "full";
      format = "<b>%s</b>\n%b";
      enable_recursive_icon_lookup = true;
      # icon_theme = config.icons.name;
      # icon_path = config.icons.path;
      browser = "${pkgs.xdg-utils}/bin/xdg-open";
      corner_radius = 0;
    };

    iconTheme = {
      inherit (config.icons) name package;
      size = "32x32";
    };

    urgency_low = with config.colorScheme.palette; {
        background = "#${base00}";
        foreground = "#${base05}";
        highlight = "#${base04}";
        timeout = 3;
    };

    urgency_normal = with config.colorScheme.palette; {
        background = "#${base00}";
        foreground = "#${base05}";
        highlight = "#${base04}";
        timeout = 3;
    };

    urgency_critical = with config.colorScheme.palette; {
        background = "#${base00}";
        foreground = "#${base05}";
        frame_color = "#${base09}";
        highlight = "#${base04}";
        timeout = 0;
    };
  };
}
