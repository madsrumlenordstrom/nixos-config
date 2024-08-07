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
     
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    git
    wget
  ];
  
  services.locate.enable = true;
  services.locate.prunePaths = [ "/mnt" ];

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
    # Use XDG directories instead of polluting home
    use-xdg-base-directories = true;
  };

  # Add flakes to nix registry (used in legacy commands)
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  system.stateVersion = "22.05";
}
