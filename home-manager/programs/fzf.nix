

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type file --follow";
    defaultOptions = with config.colorScheme.colors; [
      "--height=60%"
      "--layout=reverse"
      "--info=inline:' '"
      "--border=sharp"
      "--preview-window=border-sharp"
      " --preview '${pkgs.bat}/bin/bat -n --color=always {}'"
      "--no-scrollbar"
      "--no-separator"
      "--margin=1"
      "--color=16,border:-1"
      "--color=bg+:#${base02},bg:#${base00},spinner:#${base06},hl:#${base08}"
      "--color=info:#${base04},pointer:#${base06},gutter:-1"
      "--color=marker:#${base06},fg+:#${base05},prompt:#${base0E},hl+:#${base08}"
    ];
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type file --follow";
    fileWidgetOptions = [
      " --preview '${pkgs.bat}/bin/bat -n --color=always {}'"
    ];
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type directory --follow";
    changeDirWidgetOptions = [
      "--preview '${pkgs.eza}/bin/eza --tree --color=always --icons=always {}'"
    ];
  };
}
