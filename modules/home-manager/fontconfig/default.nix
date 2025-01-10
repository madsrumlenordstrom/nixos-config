{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.fonts.fontconfig;
in
{
  config = mkIf cfg.enable {
    fonts.fontconfig = {
      defaultFonts = {
        monospace = [ "MesloLGLDZ Nerd Font" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    home.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.meslo-lg
    ];
  };
}
