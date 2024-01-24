

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
      # # Stuff for fzf
      # set -x FZF_DEFAULT_COMMAND '${pkgs.fd}/bin/fd --type file --type directory --follow'
      # set -x FZF_CTRL_T_COMMAND "command $FZF_DEFAULT_COMMAND . \$dir 2> /dev/null"
      # set -x FZF_ALT_C_COMMAND "command ${pkgs.fd}/bin/fd --min-depth 1 --type directory --follow . \$dir 2> /dev/null"
      # set -x FZF_DEFAULT_OPTS "--height=60% --layout=reverse --info=inline:' ' --border=sharp \
      # --preview-window=border-sharp --no-scrollbar --no-separator --margin=1 --color=16,border:-1 \
      # --color=bg+:#${base02},bg:#${base00},spinner:#${base06},hl:#${base08} \
      # --color=info:#${base04},pointer:#${base06},gutter:-1 \
      # --color=marker:#${base06},fg+:#${base05},prompt:#${base0E},hl+:#${base08}"
    defaultCommand = "${pkgs.fd}/bin/fd --type file --follow";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type file --follow --preview 'bat -n --color=always {}'";
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type directory --follow";
    defaultOptions = with config.colorScheme.colors; [
      "--height=60%"
      "--layout=reverse"
      "--info=inline:' '"
      "--border=sharp"
      "--preview-window=border-sharp"
      "--no-scrollbar"
      "--no-separator"
      "--margin=1"
      "--color=16,border:-1"
      "--color=bg+:#${base02},bg:#${base00},spinner:#${base06},hl:#${base08}"
      "--color=info:#${base04},pointer:#${base06},gutter:-1"
      "--color=marker:#${base06},fg+:#${base05},prompt:#${base0E},hl+:#${base08}"
    ];
  };
}
