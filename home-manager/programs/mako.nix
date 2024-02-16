{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  services.mako = with config.colorScheme.palette; {
    enable = true;
    iconPath = config.icons.path;
    # font = "${config.fontProfiles.regular.family} 12";
    padding = "10,20";
    anchor = "top-center";
    width = 400;
    height = 150;
    borderSize = 2;
    defaultTimeout = 12000;
    backgroundColor = "#${base00}dd";
    borderColor = "#${base03}dd";
    textColor = "#${base05}dd";
    layer = "overlay";
  };
}
