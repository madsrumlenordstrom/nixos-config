{ inputs, outputs, lib, config, pkgs, modulesPath, ... }:
{
  imports = [
    # Hardware
    ./hardware.nix

    # Custom nixos modules
    outputs.nixosModules
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add flakes to nix registry (used in legacy commands)
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # Boot settings
  boot.enable = true;

  # Networking settings settings
  networking.enable = true;
  networking.hostName = "p43s";

  # SSH
  services.openssh.enable = true;

  # Time zone and locale.
  # services.automatic-timezoned.enable = true;
  time.timeZone = "Europe/Copenhagen";
  i18n.enable = true;

  # User
  users.rumle.enable = true;

  # Configure keymap
  console.keyMap = "dk-latin1";
  services.xserver.xkb = {
    layout = "dk";
    options = "grp:win_space_toggle";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;


  # Packages
  programs = {
    git.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
  environment.systemPackages = with pkgs; [
    wget
  ];

  # Fonts
  fonts.enableDefaultPackages = true;

  # Enable pipewire audio
  pipewire.enable = true;

  # Install version
  system.stateVersion = "24.11";
}

