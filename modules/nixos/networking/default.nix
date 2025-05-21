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
      wait-online.enable = false;
      networks = {
        "20-wired" = {
          matchConfig.Name = "enp*";
          linkConfig.RequiredForOnline = "routable";
          networkConfig = {
            DHCP = "yes";
            DNSOverTLS = "opportunistic";
          };
          dhcpV4Config.RouteMetric = 100;
          ipv6AcceptRAConfig.RouteMetric = 100;
        };
        "25-wireless" = {
          matchConfig.Name = "wlp*";
          linkConfig.RequiredForOnline = "routable";
          networkConfig = {
            DHCP = "yes";
            IgnoreCarrierLoss = "3s";
            DNSOverTLS = "opportunistic";
          };
          dhcpV4Config.RouteMetric = 600;
          ipv6AcceptRAConfig.RouteMetric = 600;
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
