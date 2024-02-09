{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.wofi = {
    enable = true;
    settings = {
      show = "dmenu";
      location = "center";
      width = "40%";
      lines = 10;
      always_parse_args = true;
      show_all = true;
      layer = "overlay";
      insensitive = true;
      prompt = "search";
    };
    style = with config.colorScheme.palette; /*css*/ ''
      window {
        margin: 0px;
        border: 1px solid #${base04};
        border-radius: 0px;
        background-color: #${base00};
        font-family: monospace;
        font-size: 13px;
      }

      #input {
        margin: 5px;
        border: none;
        border-radius: 0px;
        color: #${base05};
        background-color: #${base00};
      }

      #input image {
        color: #${base05};
      }

      #inner-box {
        margin: 5px;
        border: none;
        border-radius: 0px;
        border: none;
        background-color: #${base00};
      }

      #outer-box {
        margin: 0px;
        border: 1px solid #${base04};
        border-radius: 0px;
        background-color: #${base00};
      }

      #scroll {
        margin: 0px;
        border: none;
        border-radius: 0px;
      }

      #text {
        margin: 5px;
        border: none;
        border-radius: 0px;
        color: #${base05};
      }

      #entry:selected {
        background-color: #${base01};
        font-weight: normal;
        border-radius: 0px;
      }

      #entry:selected * {
        background-color: #${base01};
        font-weight: normal;
        border-radius: 0px;
      }

      #text:selected {
        background-color: #${base01};
        font-weight: normal;
      } 
    '';
  };
}
