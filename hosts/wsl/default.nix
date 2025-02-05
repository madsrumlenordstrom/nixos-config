{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    inputs.nixos-wsl.nixosModules.wsl
    inputs.vscode-server.nixosModules.default
  ];

  wsl = {
    enable = true;
    defaultUser = "rumle";
    startMenuLaunchers = true;

    wslConf = {
      network.hostname = "wsl";
      automount.root = "/mnt";
    };
  };

  services.vscode-server.enable = true;
     
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;

  environment.systemPackages = with pkgs; [
    git
    wget
  ];
  
  services.locate.enable = true;
  services.locate.prunePaths = [ "/mnt" ];

  # Add flakes to nix registry (used in legacy commands)
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  system.stateVersion = "22.05";
}
