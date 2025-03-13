{ inputs, outputs, lib, config, pkgs, ... }:
{
  # Enable commonly used CLI tools
  cli.enable = true;

  home = {
    username = "rumle";
    homeDirectory = "/home/${config.home.username}";

    stateVersion = "23.11";
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
}
