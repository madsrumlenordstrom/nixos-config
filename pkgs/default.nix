{pkgs, ... }: {
  audio-volume-control = pkgs.callPackage ./audio-volume-control { };
  mon-brightness-control = pkgs.callPackage ./mon-brightness-control { };
  kbd-brightness-control = pkgs.callPackage ./kbd-brightness-control { };
}
