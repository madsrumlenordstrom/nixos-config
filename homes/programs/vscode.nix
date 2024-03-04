{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    extensions = with pkgs.vscode-extensions; [
      # Scala/Chisel
      scalameta.metals
      scala-lang.scala

      # Nix
      jnoortheen.nix-ide
    ];

    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      };
  };

  home.packages = with pkgs; [
    # For Scala/Chisel
    jdk
  ];
}
