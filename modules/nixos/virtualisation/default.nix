{ inputs, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.virtualisation;
in
{
  options.virtualisation.enable = mkEnableOption "Virtualisation technologies";

  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd.enable = true;
    };
  };
}
