{ inputs, outputs, config, lib, pkgs, ... }:
{
  # Modules for import
  imports = [
    outputs.homeManagerModules
  ];

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

    stateVersion = "24.11";
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
