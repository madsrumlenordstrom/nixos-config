{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.pipewire;
in
{
  options.pipewire.enable = mkEnableOption "Pipewire audio";

  config = mkIf cfg.enable {
    # Realtime kit
    security.rtkit.enable = true;

    # Enable audio service
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
