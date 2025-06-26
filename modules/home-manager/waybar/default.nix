{ inputs, lib, config, pkgs, ... }:
{
  # Waits 3 seconds before restarting on crash
  systemd.user.services.waybar.Service.RestartSec = 3;
  
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    # Needs some arbitrary name
    settings.default = {
      # Positioning
      layer = "top";
      position = "top";
      height = 27;
      margin-top = lib.mkDefault 6;
      margin-left = lib.mkDefault 6;
      margin-right = lib.mkDefault 6;
      margin-bottom = lib.mkDefault 0;
      spacing = 2;

      # Modules to show
      modules-left = [ "sway/workspaces" ];
      modules-center = [ ];
      modules-right = [ "sway/mode" "wireplumber" "battery" "network" "clock" ];

      "sway/workspaces" = {
        "disable-scroll" = true;
        "all-outputs" = true;
        "disable-markup" = false;
        "format" = "{icon}";
        "format-icons" = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
        };
        "persistent-workspaces" = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
        };
      };

      "sway/mode" = { "format" = "󰲏 "; };

      "network" = {
        "format-wifi" = " ";
        "format-ethernet" = "󰈀 ";
        "format-disconnected" = "󰤯 ";
        "tooltip-format-wifi" = "{essid} ({signalStrength}%)";
        "tooltip-format-ethernet" = "{essid}";
        "tooltip-format-disconnected" = "No connection";
      };

      "wireplumber" = {
        "format" = "";
        "format-muted" = "󰖁 ";
      };

      "battery" = {
        "bat" = "BAT0";
        "adapter" = "ADP1";
        "states" = { "critical" = 15; };
        "format" = "{icon}";
        "format-charging" = " ";
        "format-plugged" = " ";
        "format-icons" = [ " " " " " " " " " " ];
        "interval" = 10;
      };

      "clock" = {
        "format" = "{:%Y-%m-%d %H:%M}";
        "format-alt" = "{:%H:%M}";
        "interval" = 60;
      };

      "sway/language" = { "format" = "{short}"; };
    };

    # Import bar style configuration
    inherit (import ./style.nix { inherit inputs lib config pkgs; }) style;
  };
}
