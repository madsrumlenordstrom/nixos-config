# NixOS configuration
Here is my NixOS and Home Manager configurations.
The configurations are provided as a flake and should currently be considered work in progress.

## Building NixOS
To build the NixOS configuration located in ```hosts/``` run the following command:

```shell
sudo nixos-rebuild --flake . switch
```

## Building home
To build the home manager configuration located in ```homes/``` run the following command:

```shell
home-manager --flake . switch
```

## Building ISO
To build the ISO image with a NixOS installer run the following command:

```shell
nix build .#packages.iso
```
