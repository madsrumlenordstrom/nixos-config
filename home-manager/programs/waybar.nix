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
      modules-left = [ "sway/mode" "sway/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "network" "wireplumber" "battery" "sway/language" ];
      height = 27;
      margin-top = 6;
      margin-left = 44; # Fixes my broken screen
      margin-right = 6;
      margin-bottom = 0;
      spacing = 2;
      "sway/window" = { "max-length" = 50; };
      "sway/workspaces" = {
        "disable-scroll" = true;
        "all-outputs" = true;
        "disable-markup" = false;
        "format" = "{icon}";
        "format-icons" = {
          "1" = "0001";
          "2" = "0010";
          "3" = "0011";
          "4" = "0100";
          "5" = "0101";
          "6" = "0110";
          "7" = "0111";
          "8" = "1000";
          "9" = "1001";
          "10" = "1010";
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
        "on-click" = "helvum";
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
      	padding: 1px 15px 1px 10px;
      }

      #workspaces button.focused:hover {
      	color: #${base05};
      }

      #workspaces button.urgent {
      	background-color: #${base0C};
      }

      #workspaces button#sway-workspace-1.focused {
      	color: #${base08};
      }

      #workspaces button#sway-workspace-2.focused {
      	color: #${base0B};
      }

      #workspaces button#sway-workspace-3.focused {
      	color: #${base0A};
      }

      #workspaces button#sway-workspace-4.focused {
      	color: #${base0D};
      }

      #workspaces button#sway-workspace-5.focused {
      	color: #${base0E};
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
