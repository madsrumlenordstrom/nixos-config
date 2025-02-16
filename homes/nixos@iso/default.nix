{ inputs, outputs, config, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    config.terminal = "${config.programs.alacritty.package}/bin/alacritty";
  };

  # Enable commonly used CLI tools
  cli.enable = true;

  programs = {
    alacritty.enable = true;  # Terminal emulator
    firefox.enable = true;    # Web browser
    imv.enable = true;        # Image viewer
    mpv.enable = true;        # Video player
    zathura.enable = true;    # Document viewer
  };

  fonts.fontconfig.enable = true;
  gtk.enable = true;

  home = {
    username = "nixos";
    homeDirectory = "/home/${config.home.username}";

    # User packages
    packages = with pkgs; [
      # TODO move to more fitting place
      nil                # LSP server for nix
    ];

    stateVersion = "24.11";
  };

  # Enable dconf as many programs read dconf data
  dconf.enable = true;

  monitors = [
    { # Built in display
      name = "*";
      width = 1920;
      height = 1080;
      refreshRate = 59.990;
      x = 0;
      y = 0;
      scale = 1.0;
      primary = true;
    }
  ];

  # Enable XDG base directories management
  xdg.enable = true;
  nix.enable = true;

  # Enable home-manager
  programs.home-manager.enable = true;
  news.display = "show";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
