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
}
