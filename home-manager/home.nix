{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Modules for import
  imports = [
    inputs.nix-colors.homeManagerModules.default
    outputs.homeManagerModules.monitors
    outputs.homeManagerModules.icons
    outputs.homeManagerModules.cursor
    ./programs/sway.nix
    ./programs/waybar.nix
    ./programs/mako.nix
    ./programs/firefox.nix
    ./programs/git.nix
    ./programs/alacritty.nix
    ./programs/fish.nix
    ./programs/starship.nix
    ./programs/gtk.nix
    ./programs/fzf.nix
    ./programs/eza.nix
    ./programs/helix.nix
    ./programs/vscode.nix
    ./programs/bat.nix
    ./programs/zathura.nix
    ./programs/wofi.nix
    ./programs/imv.nix
  ];

  # Global color scheme. See https://github.com/tinted-theming/base16-schemes
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-frappe;

  # System icon theme
  icons = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    name = if config.colorScheme.variant == "dark" then "Papirus-Dark" else "Papirus-Light";
  };

  # System cursor theme
  cursor = {
    enable = true;
    package = pkgs.capitaine-cursors;
    name = "${if config.colorScheme.variant == "dark" then "capitaine-cursors-white" else "capitaine-cursors"}";
    size = 32;
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "madsrumlenordstrom";
    homeDirectory = "/home/${config.home.username}";

    sessionVariables = {
    };

    # User packages
    packages = with pkgs; [
      hexyl              # Hexdumper
      mpv                # Media player
      transmission-gtk   # Torrent client
      gdu                # Disk usage analyzer
      wl-clipboard       # Copy paste utils
      ripgrep            # Grep but better
      htop               # Process viewer
      file               # File type analyzer
      nil                # LSP server for nix
      xdg-utils          # Useful desktop CLI tools
      tldr               # Alternative to man pages
    ];

    stateVersion = "23.11";
  };

  monitors = [
    { # Built in display
      name = "eDP-1";
      width = 2880;
      height = 1800;
      refreshRate = 59.990;
      x = 0;
      y = 1600;
      scale = 2.0;
      primary = true;
    }
    { # External monitor
      name = "HDMI-A-3";
      width = 2560;
      height = 1600;
      refreshRate = 59.972;
      x = 0;
      y = 0;
      scale = 1.0;
    }
  ];

  # Playerctl for controlling media
  services.playerctld.enable = true;

  # Enable home-manager
  programs.home-manager.enable = true;
  news.display = "show";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
