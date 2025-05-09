{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.users.rumle;
in
{
  options.users.rumle.enable = mkEnableOption "Common options for rumle";


  config = mkIf cfg.enable {
    # Enable commonly used CLI tools
    cli.enable = true;

    home = {
      username = "rumle";
      homeDirectory = "/home/${config.home.username}";
    };

    # Enable XDG base directories management
    xdg.enable = true;
    nix = {
      enable = true;
      package = pkgs.nix;
    };

    # Enable home-manager
    programs.home-manager.enable = true;
    news.display = "show";

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    services.syncthing = {
      settings = {
        devices = {
          pixel = {};
          p43s = {};
          edb = {};
        };
      };
    };
  };
}
