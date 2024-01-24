{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.eza = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [
      "--time-style=long-iso"
    ];
  };
}
