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
    inputs.nixpkgs.nixosModules.notDetected

    # My model is older but this works. This configures almost everything for an Intel laptop.
    inputs.hardware.nixosModules.apple-macbook-pro-12-1
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    # Enable hybrid codec for Intel i7-4980HQ
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver # Enable hardware enconding/decoding of video
      vaapiVdpau # Not sure if this is needed
    ];
  };

  # Force i965 VA-API driver
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "i965"; };

  # Power managerment
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;

  # Make fans as quite as possible
  # It is probably not a good idea to let the laptop run this hot. Use at your own risk
  services.mbpfan.settings.general = {
    low_temp = 60;  # If temperature is below this, fans will run at minimum speed
    high_temp = 85; # If temperature is above this, fan speed will gradually increase
    max_temp = 95;  # If temperature is above this, fans will run at maximum speed
    polling_interval = 4;
    min_fan1_speed = 1500;
    min_fan2_speed = 1500;
  };

  # Boot and module stuff
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/047f4ab3-a427-4d58-b163-1eb615317d1e";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FA70-7B0F";
    fsType = "vfat";
  };

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16*1024;
  } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
