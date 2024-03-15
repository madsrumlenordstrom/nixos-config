{ lib, config, pkgs, modulesPath, ... }:

with lib;

let
  cfg = config.wayland-session;
in
{
  options.wayland-session.enable = mkEnableOption "Wayland session";

  config = mkIf cfg.enable (mkMerge [
      # Use this module from nixpkgs
    (import (modulesPath + "/programs/wayland/wayland-session.nix") { inherit lib pkgs; })
    {
      # Disable xwayland
      programs.xwayland.enable = false;

      # Allow users group to request realtime priority
      security.pam.loginLimits = [{ domain = "@users"; item = "rtprio"; type = "-"; value = 1; }];

      # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050913
      xdg.portal.config.sway.default = [ "wlr" "gtk" ];
    }
  ]);
}
