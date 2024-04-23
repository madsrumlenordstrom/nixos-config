{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.git;
in
{
  config = mkIf cfg.enable {
    programs.git = {
      iniContent = {
        user = {
          name = "Mads Rumle Nordstrøm";
          email = "madsrumlenordstrom@icloud.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}
