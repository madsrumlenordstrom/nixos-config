{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.networking;
in
{
  options.networking.enable = mkEnableOption "Networking settings";

  config = mkIf cfg.enable {
    networking = {
      # Use iwd instead of wpa_supplicant
      wireless.iwd.enable =  true;
      networkmanager.enable = true;
      networkmanager.wifi.backend = "iwd";

      # Use nftables instead of legacy iptables
      nftables.enable = true;
      firewall = {
        enable = true;
        allowedTCPPorts = [ 22 ];
      };
    };
  };
}
