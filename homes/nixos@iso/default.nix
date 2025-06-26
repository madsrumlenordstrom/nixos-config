{ inputs, config, lib, pkgs, ... }:
{
  users.nixos.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config.terminal = "${config.programs.alacritty.package}/bin/alacritty";
  };

  programs = {
    alacritty.enable = true;  # Terminal emulator
    firefox.enable = true;    # Web browser
    imv.enable = true;        # Image viewer
    mpv.enable = true;        # Video player
    zathura.enable = true;    # Document viewer
  };

  fonts.fontconfig.enable = true;
  gtk.enable = true;

  home.stateVersion = "24.11";

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
}
