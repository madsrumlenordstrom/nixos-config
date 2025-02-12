{
  description = "My NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # WSL
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    # Others
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = inputs.nixpkgs.lib.genAttrs systems;

    mkNixosConfiguration = host: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs; };
      modules = [
        (./. + "/hosts/${host}")
        (./. + "/shared/${host}")
        inputs.nix-index-database.nixosModules.nix-index
      ];
    };

    mkHomeManagerConfiguration = { user, host, system }: inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          (./. + "/homes/${user}@${host}")
          ./shared/${host}
          inputs.nur.modules.homeManager.default
        ];
      };
  in {
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs inputs.nixpkgs.legacyPackages.${system});

    # Formatter for your nix files, available through 'nix fmt'
    formatter = forAllSystems (system: inputs.nixpkgs.legacyPackages.${system}.alejandra);

    # Custom packages and modifications, exported as overlays
    overlays = import ./overlays { inherit inputs; };

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    nixosConfigurations = {
      "edb" = mkNixosConfiguration "edb";
      "p43s" = mkNixosConfiguration "p43s";
      "wsl" = mkNixosConfiguration "wsl";
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "rumle@edb" = mkHomeManagerConfiguration { user = "rumle"; host = "edb"; system = "x86_64-linux"; };
      "rumle@p43s" = mkHomeManagerConfiguration { user = "rumle"; host = "p43s"; system = "x86_64-linux"; };
      "rumle@wsl" = mkHomeManagerConfiguration { user = "rumle"; host = "wsl"; system = "x86_64-linux"; };
    };
  };
}
