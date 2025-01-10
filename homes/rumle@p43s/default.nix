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

    stateVersion = "24.11";
  };

  # System icon theme
  icons = {
    enable = true;
    package = pkgs.papirus-icon-theme-matching;
    name = if config.colorScheme.variant == "dark" then "Papirus-Dark" else "Papirus-Light";
  };

  # System cursor theme
  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = if config.colorScheme.variant == "dark" then "capitaine-cursors-white" else "capitaine-cursors";
    size = 32;
    gtk.enable = true;
  };

  # Enable dconf as many programs read dconf data
  dconf.enable = true;

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.nur-packages
      # outputs.overlays.unstable-packages

      # Make papirus icons match color theme
      (final: prev: {
        papirus-icon-theme-matching = prev.papirus-icon-theme.overrideAttrs (oldAttrs: {
          buildPhase = /* sh */ ''
            find ${if config.colorScheme.variant == "dark" then "Papirus-Dark" else "Papirus-Light"}/symbolic -type f -exec sed -i 's/#${if config.colorScheme.variant == "dark" then "dfdfdf" else "444444"}/#${config.colorScheme.palette.base05}/g' {} +
          '';
          dontPatchELF = true;
          dontPatchShebangs = true;
          dontRewriteSymlinks = true;
        });
      })
    ];

    config.allowUnfree = true;
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
