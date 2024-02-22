{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    # Hardware
    ./edb-hardware.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Boot loader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Add flakes to nix registry (used in legacy commands)
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # Networking
  networking = {
    hostName = "edb";
    networkmanager.enable = true;
    interfaces.wlp3s0.ipv4.addresses = [ {
      address = "192.168.1.129";
      prefixLength = 24;
    } ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  # SSH
  services.openssh.enable = true;

  # Time zone and locale.
  services.automatic-timezoned.enable = true;
  i18n = { 
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = lib.mkDefault "da_DK.UTF-8";
    };
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "da_DK.UTF-8/UTF-8"
    ];
  };

  # User
  users.users.madsrumlenordstrom = {
    description = "Mads Rumle Nordstrøm";
    isNormalUser = true;
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
    brightnessctl
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
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "MesloLGLDZ Nerd Font" ];
    };
  };

  # Make system prepared for a wayland compositor
  security = { 
    polkit.enable = true;
    pam = {
      # Needed for swaylock authentications
      services.swaylock = {};
      # Allow user programs to request realtime priority
      loginLimits = [{ domain = "@users"; item = "rtprio"; type = "-"; value = 1; }];
    };
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.sway.default = [ "wlr" "gtk" ];
  };

  # Greeter before compositor
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --remember --time --time-format '%Y-%m-%d %H:%M' --asterisks --cmd sway";
      user = "greeter";
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

