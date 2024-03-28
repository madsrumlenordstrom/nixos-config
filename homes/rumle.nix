{ inputs, outputs, lib, config, pkgs, ... }:
{
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
      # outputs.overlays.unstable-packages

      # Make papirus icons match color theme
      (final: prev: {
        papirus-icon-theme = prev.papirus-icon-theme.overrideAttrs (oldAttrs: {
          installPhase = oldAttrs.installPhase + ''
            find $out/share/icons/${if config.colorScheme.variant == "dark" then "Papirus-Dark" else "Papirus-Light"}/symbolic -type f -exec sed -i 's/#${if config.colorScheme.variant == "dark" then "dfdfdf" else "444444"}/#${config.colorScheme.palette.base05}/g' {} +
          '';
        });
      })
    ];

    config.allowUnfree = true;
  };

  # Enable XDG base directories management
  xdg.enable = true;

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
