{ inputs, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.bat;
in
{
  config = mkIf cfg.enable {
    programs.bat = {
      config.theme = "base16";
    };
  };
}
