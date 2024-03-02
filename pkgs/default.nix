{pkgs, ... }: {
  volume-control = pkgs.callPackage ./volume-control { };
  brightness-control = pkgs.callPackage ./brightness-control { };
  kb-brightness-control = pkgs.callPackage ./kb-brightness-control { };
}
