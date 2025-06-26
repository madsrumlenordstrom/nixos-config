{ inputs, config, lib, pkgs, ... }:
{
  language-server = {
    nixd.command = "${pkgs.nixd}/bin/nixd";
  };

  language = [
    {
      name = "nix";
      language-servers = ["nixd"];
    }
  ];
}
