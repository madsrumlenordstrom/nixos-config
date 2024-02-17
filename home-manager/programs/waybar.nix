{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.waybar = {
    enable = true;
    settings.main = { # Needs some arbitrary name
      layer = "top";
      position = "top";
      height = 27;
      margin-top = 6;
      margin-left = 44; # Fixes my broken screen
      margin-right = 6;
      margin-bottom = 0;
      spacing = 2;

      modules-left = [ "sway/mode" "sway/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "network" "wireplumber" "battery" "sway/language" ];

      "sway/window" = { "max-length" = 50; };
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
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
        };
        "persistent-workspaces" = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
        };
      };

      "sway/mode" = { "format" = "{}"; };

      "network" = {
        "format-wifi" = " {signalStrength:3}%";
        "format-ethernet" = "{ifname} = {ipaddr}/{cidr}";
        "format-linked" = "{ifname} (No IP)";
        "format-disconnected" = "󰤯  {signalStrength:3}%";
      };

      "wireplumber" = {
        "format" = " {volume:3}%";
        "format-muted" = "󰖁 {volume:3}%";
      };

      "battery" = {
        "bat" = "BAT0";
        "adapter" = "ADP1";
        "states" = {
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{icon}  {capacity:3}%";
        "format-charging" = " {capacity:3}%";
        "format-plugged" = "  {capacity:3}%";
        "format-icons" = [ "" "" "" "" "" ];
        "interval" = 10;
      };

      "clock" = {
        "format" = " {:%H:%M}";
        "format-alt" = " {:%Y-%m-%d %H:%M}";
        "interval" = 60;
      };

      "sway/language" = { "format" = "  {short}"; };
    };

    style = with config.colorScheme.palette; /*css*/ ''
      * {
      	border: 2px;
      	border-radius: 0;
      	font-family: "monospace";
      	font-size: 14px;
      	min-height: 0;
      }

      window#waybar {
      	background: #${base00};
      	border: 1px solid #${base04};
      	opacity: 1.00;
      }

      #workspaces {
      	border-bottom: 1px solid #${base04};
      	border-top: 1px solid #${base04};
      	margin: 0px;
      }

      #workspaces button {
      	color: #${base05};
      	background: #${base00};
      	padding: 1px 5px 1px 5px;
      }

      #workspaces button.hover {
      	background-color: #${base05};
      }

      #workspaces button.urgent {
      	background-color: #${base08};
      }

      #workspaces button.focused {
      	color: #${base05};
      	background-color: #${base01};
      }

      .modules-left>widget:first-child>#workspaces {
      	border-left: 1px solid #${base04};
      }

      #mode {
      	color: #${base00};
      	background-color: #${base08};
      	padding: 0 10px;
      }

      #custom-date,
      #clock,
      #battery,
      #wireplumber,
      #network,
      #language {
      	background: #${base00};
      	padding: 0px 10px 2px 10px;
      	color: #${base05};
      	border-bottom: 1px solid #${base04};
      	border-top: 1px solid #${base04};
      }

      #language {
      	border-right: 1px solid #${base04};
      }

      @keyframes blink {
      	to {
      		background-color: #ffffff;
      		color: black;
      	}
      }

      #battery.charging {}

      #battery.critical:not(.charging) {
      	background-color: #f53c3c;
      	color: #ffffff;
      	animation-name: blink;
      	animation-duration: 0.5s;
      	animation-timing-function: linear;
      	animation-iteration-count: infinite;
      	animation-direction: alternate;
      }
    '';
  };
}
