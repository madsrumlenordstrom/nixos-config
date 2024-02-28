{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  # General settings for Firefox
  settings = import ./settings.nix { inherit inputs outputs lib config pkgs; };

  # Search engines
  engines = import ./engines.nix { inherit inputs outputs lib config pkgs; };

  # Chrome styling
  userChrome = (import ./chrome.nix { inherit inputs outputs lib config pkgs; }).userChrome;
  userContent = (import ./chrome.nix { inherit inputs outputs lib config pkgs; }).userContent;
in {

  # Set as default browser
  home.sessionVariables.BROWSER = lib.mkIf config.programs.firefox.enable "firefox";

  programs.firefox = {
    enable = true;
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
        extensions = with config.nur.repos.rycee.firefox-addons; [
          darkreader
          ublock-origin
          sponsorblock
          h264ify
        ];
      };
    };
  };
}
