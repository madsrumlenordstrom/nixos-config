{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.bat = {
    enable = true;
    config.theme = "base16";
  };
}
