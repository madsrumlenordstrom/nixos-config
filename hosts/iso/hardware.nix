{ inputs, outputs, lib, config, pkgs, modulesPath, ... }:
{
  imports = [
    inputs.nixpkgs.nixosModules.notDetected

    inputs.nixos-hardware.nixosModules.common-cpu-intel
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    bluetooth.enable = true;

    cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };

  # Boot and module stuff
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
