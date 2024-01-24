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
      la = "eza -la --icons --time-style=long-iso";
      ll = "eza -l --icons --time-style=long-iso";
      ls = "eza";
      tree = "eza --tree";
      mkdir = "mkdir -p";
      rp = { setCursor = true; expansion = "realpath -z % |xargs --null -I -- echo 'wl-copy --' |sh"; };
      wg = "wl-paste | xargs -I % echo 'wget --no-hsts %' | sh";

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
    };
    functions = {
      kat = {};
    };
  };
}
