{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    # Hardware
    ./hardware.nix
  ];

  # Add flakes to nix registry (used in legacy commands)
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # Boot settings
  boot.enable = true;

  # Networking settings
  networking.enable = true;
  networking.hostName = "edb";

  # SSH
  services.openssh.enable = true;

  # Time zone and locale.
  services.automatic-timezoned.enable = true;
  # TODO: remove when this is merged: https://github.com/NixOS/nixpkgs/pull/391845
  services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
  services.geoclue2.submissionUrl = "https://api.beacondb.net/v2/geosubmit";
  i18n.enable = true;

  # User
  users.rumle.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  # Enable virtualisation technologies
  virtualisation.enable = true;

  # Fonts
  fonts.enableDefaultPackages = true;
 
  # Make system prepared for a wayland compositor
  wayland-session.enable = true;

  # Enable display manager
  tuigreet.enable = true;

  # Enable pipewire audio
  pipewire.enable = true;

  # Large font for HiDPI display
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";

  # Install version
  system.stateVersion = "23.05";
}

