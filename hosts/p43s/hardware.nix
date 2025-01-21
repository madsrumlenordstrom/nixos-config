{ inputs, outputs, lib, config, pkgs, modulesPath, ... }:
{
  imports = [
    inputs.nixpkgs.nixosModules.notDetected

    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-sync
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      open = false;
      prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:60:0:0";
      };
      # fix suspend/resume screen corruption in sync mode
      powerManagement.enable = lib.mkDefault config.hardware.nvidia.prime.sync.enable;

      # fix screen tearing in sync mode
      modesetting.enable = lib.mkDefault config.hardware.nvidia.prime.sync.enable;
    };

    bluetooth.enable = true;

    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  services.throttled.enable = lib.mkDefault true;

  # Boot and module stuff
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ea60f739-6305-4959-b746-c8918681c1bf";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2220-E15F";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16*1024;
  } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
