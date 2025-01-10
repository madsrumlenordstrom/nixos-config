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

  # User
  users.users.rumle = {
    description = "Mads Rumle Nordstrøm";
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    hashedPassword = "$y$j9T$.uZNPXk3OFWaoNetj2P2e0$6rD7ex86u17L78b0wKQ.QzXd3cZUVkAPifTs7r.L3l5";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvT9oPm1+tMYdUp4pngUjDciJpKP0kPlxmyJDQh6+Nb7f2AwW+C7BGEPADcf0yHtG8FYW/9MkfpCZcMoatsMSQnW1Wtzf3Xrjl59AGhuGc9Yc5stC6JLgWhosNpVoiZ44s0lU7vxMMVws+dBqmnanjYOqsKkVMBhmel9pfusY+gFvhRLGJQB98Ck+D5h/5VLefidM8d4hcnt0CK8+4/jMNIPojyx5j63yAG4vKZemJVgeBUM3enftfi7onY7xpuI7dhY4jWnp0JnPww8VIYHrbfZRc3XdpeTVMWF7oZB05nqkuOYUPanQp4jDIf/tdJTHwvv2ZnxmuxwheeLNDw2lMSmuogX2Zv+x91CHHHAWJFEWrcv7CKSL5LDS8fuw4Nw1Y/tjtZIIMfCXGLvxinZVAnCF/OOpyPNZIxn0bqrIVO42cF0smciWEeEIzvtiTzNJXdhIO/eg9dOWnBAq+PYIl+LxsCYrqcFgrhol9a6yX/DlUFBAbRbvuEY3SIVFV5O0= madsrumlenordstrom@arch"
    ];
  };

  # Make sure fish is available
  programs.fish.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  # Fonts
  fonts.enableDefaultPackages = true;

  # Enable pipewire audio
  pipewire.enable = true;

  # Install version
  system.stateVersion = "24.11";
}

