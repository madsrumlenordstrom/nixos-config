{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.cli;
in
{
  options.cli = {
    enable = mkEnableOption "Commonly used CLI tools";
  };

  config = mkIf cfg.enable {
    programs = {
      bat.enable = true;        # Terminal file viewer
      eza.enable = true;        # Modern ls
      fd.enable = true;         # Modern find
      fish.enable = true;       # Shell
      fzf.enable = true;        # Fuzzy finder
      git.enable = true;        # VCS
      helix.enable = true;      # Text editor
      htop.enable = true;       # System monitor
      ripgrep.enable = true;    # Modern grep
      starship.enable = true;   # Shell prompt
      tokei.enable = true;      # Source code counter
    };

    home.packages = with pkgs; [
      hexyl                     # Hexdumper
      gdu                       # Disk usage analyzer
      file                      # File type analyzer
      tldr                      # Alternative to man pages
    ];
  };
}
