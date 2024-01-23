{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    iniContent = {
      user = {
        name = "Mads Rumle Nordstrøm";
        email = "madsrumlenordstrom@icloud.com";
      };
      init.defaultBranch = "main";
    };
  };
}
