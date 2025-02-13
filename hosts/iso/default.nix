{ inputs, outputs, lib, config, pkgs, modulesPath, ... }:
{
  imports = [
    # Hardware
    ./hardware.nix

    # Custom nixos modules
    outputs.nixosModules

    # Create an ISO image with KDE
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  # Add flakes to nix registry (used in legacy commands)
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # Networking settings settings
  # networking.enable = true;
  networking.hostName = "iso";

  # SSH
  services.openssh.enable = true;

  # Time zone and locale.
  # services.automatic-timezoned.enable = true;
  time.timeZone = "Europe/Copenhagen";
  i18n.enable = true;

  # User
  users.nixos.enable = true;

  # Configure keymap
  console.keyMap = "dk-latin1";
  services.xserver.xkb = {
    layout = "dk";
    options = "grp:win_space_toggle";
  };

  # Packages
  programs = {
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  # Fonts
  fonts.enableDefaultPackages = true;

  # Enable pipewire audio
  pipewire.enable = true;
}

