{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.networking;
in
{
  options.networking.enable = mkEnableOption "Networking settings";

  config = mkIf cfg.enable {
    systemd.network = {
      enable = true;
      wait-online.anyInterface = true;
      wait-online.timeout = 20;
      networks = {
        "25-wireless" = {
          matchConfig.Name = "wlp*";
          linkConfig.RequiredForOnline = "routable";
          networkConfig = {
            DHCP = "yes";
            IgnoreCarrierLoss = "3s";
            DNSOverTLS = "opportunistic";
          };
        };
      };
      # Use predictable naming scheme
      links."80-iwd".linkConfig.NamePolicy = mkForce "database onboard slot path mac keep kernel";
    };

    networking = {
      # DHCP managed by networkd
      useDHCP = false;

      # Use nftables instead of legacy iptables
      nftables.enable = true;
      firewall.enable = true;

      # Wireless daemon
      wireless.iwd.enable = true;
    };
  };
}
