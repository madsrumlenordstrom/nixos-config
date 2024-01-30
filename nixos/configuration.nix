{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
      # Hardware
      ./hardware-configuration.nix
      inputs.hardware.nixosModules.apple-macbook-pro-12-1
    ];

  # Booting
  boot = {
    # Boot loader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Add flakes to nix registry
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    interfaces.wlp3s0.ipv4.addresses = [ {
      address = "192.168.1.129";
      prefixLength = 24;
    } ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
    };
  };

  # SSH
  services.openssh.enable = true;

  # Time zone and locale.
  time.timeZone = "Europe/Copenhagen";
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # User
  users.users.madsrumlenordstrom = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    hashedPassword = "$y$j9T$.uZNPXk3OFWaoNetj2P2e0$6rD7ex86u17L78b0wKQ.QzXd3cZUVkAPifTs7r.L3l5";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvT9oPm1+tMYdUp4pngUjDciJpKP0kPlxmyJDQh6+Nb7f2AwW+C7BGEPADcf0yHtG8FYW/9MkfpCZcMoatsMSQnW1Wtzf3Xrjl59AGhuGc9Yc5stC6JLgWhosNpVoiZ44s0lU7vxMMVws+dBqmnanjYOqsKkVMBhmel9pfusY+gFvhRLGJQB98Ck+D5h/5VLefidM8d4hcnt0CK8+4/jMNIPojyx5j63yAG4vKZemJVgeBUM3enftfi7onY7xpuI7dhY4jWnp0JnPww8VIYHrbfZRc3XdpeTVMWF7oZB05nqkuOYUPanQp4jDIf/tdJTHwvv2ZnxmuxwheeLNDw2lMSmuogX2Zv+x91CHHHAWJFEWrcv7CKSL5LDS8fuw4Nw1Y/tjtZIIMfCXGLvxinZVAnCF/OOpyPNZIxn0bqrIVO42cF0smciWEeEIzvtiTzNJXdhIO/eg9dOWnBAq+PYIl+LxsCYrqcFgrhol9a6yX/DlUFBAbRbvuEY3SIVFV5O0= madsrumlenordstrom@arch"
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    wget
    git
    bottom
    nix-index
    brightnessctl
    playerctl
    htop
    nil
    waybar
    ripgrep
    wofi
    wl-clipboard
    gammastep
    file
    capitaine-cursors
  ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "MesloLGLDZ Nerd Font" ];
      };
    };
  };

  # Shell
  programs.fish.enable = true;
  environment.shells = with pkgs; [
    fish
  ];
  users.defaultUserShell = pkgs.fish;

  # Sway WM
  programs.sway.enable = true;
  xdg.portal.wlr.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd sway";
      };
    };
  };


  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Install version
  system.stateVersion = "23.05";
}

