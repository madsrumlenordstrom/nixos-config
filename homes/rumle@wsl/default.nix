{ inputs, outputs, lib, config, pkgs, ... }:
{
  # Modules for import
  imports = [
    inputs.nix-colors.homeManagerModules.default
    outputs.homeManagerModules
  ];

    programs.git.enable = true;
    programs.fish.enable = true;
    programs.starship.enable = true;
    programs.fzf.enable = true;
    programs.eza.enable = true;
    programs.helix.enable = true;
    programs.bat.enable = true;

  home = {
    username = "rumle";
    homeDirectory = "/home/${config.home.username}";

    # User packages
    packages = with pkgs; [
      # CLI programs
      hexyl              # Hexdumper
      gdu                # Disk usage analyzer
      ripgrep            # Grep but better
      fd                 # Find but better
      htop               # Process viewer
      file               # File type analyzer
      tldr               # Alternative to man pages
      tokei              # Source code counter

      # TODO move to more fitting place
      wl-clipboard       # Copy paste utils
      nil                # LSP server for nix
      xdg-utils          # Useful desktop CLI tools
    ];

    stateVersion = "23.11";
  };

  # Global color scheme. See https://github.com/tinted-theming/base16-schemes
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-frappe;

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.nur-packages
      # outputs.overlays.unstable-packages

    ];

    config.allowUnfree = true;
  };

  # Enable XDG base directories management
  xdg.enable = true;

  # Enable home-manager
  programs.home-manager.enable = true;
  news.display = "show";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
