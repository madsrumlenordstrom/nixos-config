{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  style = with config.colorScheme.palette; /* css */ ''
    * {
      border: none;
    	border-radius: 0;
    	font-family: monospace;
    	font-size: 14px;
    	min-height: 0;
    }

    window#waybar {
      border: 1px solid #${base04};
    	background: #${base00};
    }

    #workspaces {
      border-top: 1px solid #${base04};
      border-bottom: 1px solid #${base04};
    	margin: 0px;
    }

    #workspaces button {
      color: #${base05};
      background: #${base00};
    	padding: 1px 0px 1px 0px;
    }

    #workspaces button:hover {
    	background-color: #${base02};
    }

    #workspaces button.urgent {
    	background-color: #${base08};
    }

    #workspaces button.focused {
    	background-color: #${base00};
    }

    .modules-left>widget:first-child>#workspaces {
      border-left: 1px solid #${base04};
    }

    #clock,
    #battery,
    #network,
    #wireplumber.muted,
    #mode {
    	background: #${base00};
    	padding: 0px 10px 2px 10px;
    	color: #${base05};
      border-top: 1px solid #${base04};
      border-bottom: 1px solid #${base04};
    }
    
    #clock {
      border-right: 1px solid #${base04};
      padding-right: 15px;
    }

    tooltip {
      background: #${base00};
    	border: 1px solid #${base04};
      color: #${base05};
    }

    @keyframes blink {
    	to {
    		color: #${base08};
    	}
    }

    #battery.critical:not(.charging) {
    	color: #${base05};
    	animation-name: blink;
    	animation-duration: 0.5s;
    	animation-timing-function: linear;
    	animation-iteration-count: infinite;
    	animation-direction: alternate;
    }
  '';
}
