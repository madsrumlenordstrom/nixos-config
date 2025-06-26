{ inputs, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.eza;
in
{
  config = mkIf cfg.enable {
    programs.eza = {
      git = true;
      icons = "auto";
      extraOptions = [ "--time-style=long-iso" ];
    };
  };
}
