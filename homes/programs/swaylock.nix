{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.swaylock = {
    enable = true;
    settings = {
      # General
      ignore-empty-password = true;
      show-failed-attempts = true;
      daemonize = true;
      font = "JetBrains-Mono-Medium-Nerd-Font-Complete"; # TODO
      image = "~/Pictures/wallpapers/the-glow-transparent.png"; # TODO
      color = "${config.colorScheme.palette.base02}"; # Fallback color

      # Ring
      indicator-radius = 60;
      indicator-thickness = 8;

      # Colors (TODO maybe use nix-colors here?)
      inside-color = "0000001c";
      ring-color = "0000003e";
      line-color = "00000000";
      key-hl-color = "00000050";
      ring-ver-color = "ffffff00";
      separator-color = "00000000";
      inside-ver-color = "ff99441c";
      ring-clear-color = "ff994430";
      inside-clear-color = "ff994400";
      ring-wrong-color = "ffffff55";
      inside-wrong-color = "ffffff1c";
      text-ver-color = "00000000";
      text-wrong-color = "00000000";
      text-caps-lock-color = "00000000";
      text-clear-color = "00000000";
      line-clear-color = "00000000";
      line-wrong-color = "00000000";
      line-ver-color = "00000000";
      text-color = "DB3300FF";
    };
  };
}
