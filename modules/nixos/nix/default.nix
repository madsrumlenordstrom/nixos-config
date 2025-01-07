{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.nix;
in
{
  config = mkIf cfg.enable {
    nix.settings = {
      # Enable flakes and new 'nix' command
      experimental-features = [ "nix-command" "flakes" ];
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      # Use XDG directories instead of polluting home
      use-xdg-base-directories = true;
      # Add root and wheel group to trusted users
      trusted-users = [ "root" "@wheel" ];
    };
  };
}
