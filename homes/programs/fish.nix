{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      # Nix abbreviations
      n = "nix";
      nd = "nix develop -c $SHELL";
      ns = {setCursor = true; expansion = "nix shell nixpkgs#%"; };
      snrs = "sudo nixos-rebuild --flake . switch";
      hms = "home-manager --flake . switch";

      # Git abbreviations
      ga = "git add";
      grs = "git restore";
      gc = { setCursor = true; expansion = "git commit -m \"%\""; };
      gs = "git status";
      gd = "git diff";
      gp = "git push";
      gb = "git branch";
      gco = "git checkout";
      gl = "git log";
      gpl = "git pull";
      gcl = "wl-paste | xargs -I % echo 'git clone %' | sh";

      # Other
      mkdir = "mkdir -p";
      rp = { setCursor = true; expansion = "realpath -z % |xargs --null -I -- echo 'wl-copy --' |sh"; };
      wg = "wl-paste | xargs -I % echo 'wget --no-hsts %' | sh";
    };
    functions = {
      fish_greeting = "";
    };
    interactiveShellInit = with config.colorScheme.palette; /*fish*/ ''
      # Delete word on control + backspace
      bind \b backward-kill-word

      # Colors
      set -U fish_color_autosuggestion ${base04}
      set -U fish_color_cancel ${base08} # ^C
      set -U fish_color_command ${base0D}
      set -U fish_color_comment ${base04}
      set -U fish_color_cwd ${base0A}
      set -U fish_color_cwd_root ${base08}
      set -U fish_color_end ${base05} # ; & |
      set -U fish_color_error ${base08}
      set -U fish_color_escape ${base0C} # eg. \n
      set -U fish_color_gray ${base04}
      set -U fish_color_history_current --bold
      set -U fish_color_host ${base0B}
      set -U fish_color_host_remote ${base0B}
      set -U fish_color_keyword ${base0E}
      set -U fish_color_normal ${base05}
      set -U fish_color_operator ${base05}
      set -U fish_color_option ${base0A}
      set -U fish_color_param ${base0C}
      set -U fish_color_quote ${base0B}
      set -U fish_color_redirection ${base0F}
      set -U fish_color_search_match --background=${base02}
      set -U fish_color_selection --background=${base02}
      set -U fish_color_status ${base08}
      set -U fish_color_user ${base0C}
      set -U fish_color_valid_pat --underline
      set -U fish_pager_color_background \x1d
      set -U fish_pager_color_completion ${base05}
      set -U fish_pager_color_description ${base04}
      set -U fish_pager_color_prefix ${base0F}
      set -U fish_pager_color_progress ${base04}
    '';
  };
}
