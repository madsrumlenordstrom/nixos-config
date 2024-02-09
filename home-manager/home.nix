{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./programs/sway.nix
    ./programs/waybar.nix
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

  # Global color scheme
  # See https://github.com/tinted-theming/base16-schemes
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-frappe;
  # colorScheme = inputs.nix-colors.colorSchemes.catppuccin-latte;
  # colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  # colorScheme = inputs.nix-colors.colorSchemes.nord;
  # colorScheme = inputs.nix-colors.colorSchemes.brushtrees-dark;

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
      # EDITOR = "hx"
    };

    packages = with pkgs; [
      hexyl
      mpv
      transmission-gtk # Torrent client
      gdu
    ];

    stateVersion = "23.11";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager
  programs.home-manager.enable = true;
  news.display = "show";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
