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

    allPackages = forAllSystems (system: import inputs.nixpkgs {
      inherit system;
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
        inputs.nur.overlays.default
      ];
      config.allowUnfree = true;
    });

    mkNixosConfiguration = { host, system, extraModules ? [ ] }: inputs.nixpkgs.lib.nixosSystem {
      pkgs = allPackages.${system};
      specialArgs = { inherit inputs outputs; };
      modules = [
        (./. + "/hosts/${host}")
        (./. + "/shared/${host}")
        inputs.nix-index-database.nixosModules.nix-index
      ] ++ extraModules;
    };

    mkHomeManagerConfiguration = { user, host, system, extraModules ? [ ] }: inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = allPackages.${system};
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          outputs.homeManagerModules
          (./. + "/homes/${user}@${host}")
          ./shared/${host}
          inputs.nur.modules.homeManager.default
        ] ++ extraModules;
      };
  in {
    # ISO image
    packages = forAllSystems (system: import ./pkgs allPackages.${system}) // { iso = self.nixosConfigurations.iso.config.system.build.isoImage; };

    # Custom packages and modifications, exported as overlays
    overlays = import ./overlays { inherit inputs; };

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    nixosConfigurations = {
      "edb" = mkNixosConfiguration { host = "edb"; system = "x86_64-linux"; };
      "p43s" = mkNixosConfiguration { host = "p43s"; system = "x86_64-linux"; };
      "wsl" = mkNixosConfiguration { host = "wsl"; system = "x86_64-linux"; };
      "iso" = mkNixosConfiguration {
        host = "iso";
        system = "x86_64-linux";
        extraModules = [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs outputs; };
              users.nixos.imports = [
                outputs.homeManagerModules
                (./. + "/homes/nixos@iso")
                ./shared/iso
                inputs.nur.modules.homeManager.default
              ];
            };
          }
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "rumle@edb" = mkHomeManagerConfiguration { user = "rumle"; host = "edb"; system = "x86_64-linux"; };
      "rumle@p43s" = mkHomeManagerConfiguration { user = "rumle"; host = "p43s"; system = "x86_64-linux"; };
      "rumle@wsl" = mkHomeManagerConfiguration { user = "rumle"; host = "wsl"; system = "x86_64-linux"; };
    };
  };
}
