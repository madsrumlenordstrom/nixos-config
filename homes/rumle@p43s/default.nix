{ inputs, outputs, config, lib, pkgs, ... }:
{
  users.rumle.enable = true;
  
  wayland.windowManager.sway = {
    enable = true;
    config.terminal = "${config.programs.alacritty.package}/bin/alacritty";
    wallpaper = "~/Android Camera/Camera/PXL_20250418_143800423.MP.jpg";
    config.input."type:keyboard".xkb_layout = "dk";
  };

  programs = {
    alacritty.enable = true;  # Terminal emulator
    librewolf.enable = true;  # Web browser
    imv.enable = true;        # Image viewer
    mpv.enable = true;        # Video player
    vscode.enable = true;     # GUI text editor
    zathura.enable = true;    # Document viewer
  };

  fonts.fontconfig.enable = true;
  gtk.enable = true;

  home = {
    # User packages
    packages = with pkgs; [
      # Graphical programs
      qbittorrent        # Torrent client
      libreoffice        # Office suite
      signal-desktop     # Message application
      element-desktop    # Matrix client
      tutanota-desktop   # Email client
      keepassxc          # Password manager
    ];

    stateVersion = "24.11";
  };

  services.syncthing.enable = true;

  # Enable dconf as many programs read dconf data
  dconf.enable = true;

  monitors = [
    { # Built in display
      name = "eDP-1";
      width = 1920;
      height = 1080;
        refreshRate = 60.001;
      x = 0;
      y = 0;
      scale = 1.0;
      primary = true;
    }
  ];
}
