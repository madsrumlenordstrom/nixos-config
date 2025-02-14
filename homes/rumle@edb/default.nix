{ inputs, outputs, config, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wallpaper = ~/Pictures/wallpapers/the-glow-transparent.png;
  };

  # Enable commonly used CLI tools
  cli.enable = true;

  programs = {
    alacritty.enable = true;  # Terminal emulator
    firefox.enable = true;    # Web browser
    imv.enable = true;        # Image viewer
    mpv.enable = true;        # Video player
    vscode.enable = true;     # GUI text editor
    zathura.enable = true;    # Document viewer
  };

  fonts.fontconfig.enable = true;
  gtk.enable = true;

  home = {
    username = "rumle";
    homeDirectory = "/home/${config.home.username}";

    # User packages
    packages = with pkgs; [
      # Graphical programs
      transmission_4-gtk # Torrent client
      libreoffice        # Office suite
      signal-desktop     # Message application

      # TODO move to more fitting place
      nil                # LSP server for nix
    ];

    stateVersion = "23.11";
  };

  # Workaround for my broken display :(
  wayland.windowManager.sway.config.gaps.bottom = 350;
  wayland.windowManager.sway.config.gaps.left = 295;
  programs.waybar.settings.main.margin-left = config.wayland.windowManager.sway.config.gaps.left + 12;
  programs.yambar.settings.bar.border.left-margin = 2 * config.wayland.windowManager.sway.config.gaps.left + 12;

  # Enable dconf as many programs read dconf data
  dconf.enable = true;

  # Enable XDG base directories management
  xdg.enable = true;
  nix = {
    enable = true;
    package = pkgs.nix;
  };

  monitors = [
    { # Built in display
      name = "eDP-1";
      width = 2880;
      height = 1800;
      refreshRate = 59.990;
      x = 0;
      y = 1440;
      scale = 2.0;
      primary = true;
    }
    { # External monitor
      name = "HDMI-A-3";
      width = 2560;
      height = 1440;
      refreshRate = 59.972;
      x = 0;
      y = 0;
      scale = 1.0;
    }
  ];

  # Enable home-manager
  programs.home-manager.enable = true;
  news.display = "show";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
