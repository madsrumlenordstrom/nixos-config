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
    extensions = with pkgs.vscode-extensions; [
      # Scala/Chisel
      scalameta.metals
      scala-lang.scala
    ];
    mutableExtensionsDir = false;
  };
}
