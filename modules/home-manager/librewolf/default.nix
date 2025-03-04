{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.librewolf;

  # General settings for Librewolf
  settings = import ./settings.nix { inherit config lib pkgs; };

  # Search engines
  engines = import ./engines.nix { inherit config lib pkgs; };

  # Chrome styling
  userChrome = (import ./chrome.nix { inherit config lib pkgs; }).userChrome;
  userContent = (import ./chrome.nix { inherit config lib pkgs; }).userContent;
in {
  config = mkIf cfg.enable {
    # Set as default browser
    home.sessionVariables.BROWSER = "librewolf";
  
    programs.librewolf = {
      profiles = {
        default = {
          isDefault = true;
          search = {
            default = "DuckDuckGo";
            force = true;
            inherit engines;
          };
  
          inherit userChrome userContent settings;
  
          # Extentions must be manually enabled on first launch
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            darkreader
            ublock-origin
            sponsorblock
            h264ify
            danish-dictionary
            danish-language-pack
          ];
        };
      };
    };
  };
}
