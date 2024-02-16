{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    temperature = {
      day = 6500;
      night = 1800;
    };
    settings.general = {
      fade = 1;
      adjustment-method = "wayland";
    };
  };
}
