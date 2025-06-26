{ inputs, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.users;
in
{
  imports = [
    ./rumle.nix
    ./nixos.nix
  ];

  # options.users = mkOption {
  #   default = { };
  #   description = ''
  #     User which are available in home-manager configuration.
  #   '';
  # };
}
