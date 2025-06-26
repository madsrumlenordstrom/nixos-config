{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    inputs.nixpkgs.nixosModules.notDetected
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p43s
  ];

  services.fwupd.enable = true;

  # Boot and module stuff
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

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

  nixpkgs.hostPlatform = "x86_64-linux";
}
