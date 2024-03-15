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
    outputs.homeManagerModules
    ./programs/sway.nix
    ./programs/firefox
    ./programs/git.nix
    ./programs/alacritty.nix
    ./programs/fish.nix
    ./programs/starship.nix
    ./programs/gtk.nix
    ./programs/fzf.nix
    ./programs/eza.nix
    ./programs/helix
    ./programs/vscode.nix
    ./programs/bat.nix
    ./programs/zathura.nix
    ./programs/imv.nix
  ];

  # Workaround for my broken display :(
  wayland.windowManager.sway.config.gaps.left = 38;
  programs.waybar.settings.main.margin-left = 44;
  programs.yambar.settings.bar.border.left-margin = 2 * 44;

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
    username = "rumle";
    homeDirectory = "/home/${config.home.username}";

    # User packages
    packages = with pkgs; [
      # CLI programs
      hexyl              # Hexdumper
      gdu                # Disk usage analyzer
      ripgrep            # Grep but better
      htop               # Process viewer
      file               # File type analyzer
      tldr               # Alternative to man pages
      tokei              # Source code counter

      # Graphical programs
      transmission-gtk   # Torrent client
      mpv                # Media player

      # TODO move to more fitting place
      wl-clipboard       # Copy paste utils
      nil                # LSP server for nix
      xdg-utils          # Useful desktop CLI tools
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
