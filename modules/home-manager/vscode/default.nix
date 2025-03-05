{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.vscode;
in
{
  config = mkIf cfg.enable {
    programs.vscode = {
      package = pkgs.vscode;

      mutableExtensionsDir = false;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = with pkgs.vscode-extensions; [
          # Scala/Chisel
          scalameta.metals
          scala-lang.scala

          # Nix
          jnoortheen.nix-ide

          # Theme
          catppuccin.catppuccin-vsc
        ];

        userSettings = {
          "telemetry.telemetryLevel" = "off";
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "workbench.colorTheme" = "Catppuccin Frappé";
        };
      };
    };

    home.packages = with pkgs; [
      # For Scala/Chisel
      jdk
    ];
  };
}
