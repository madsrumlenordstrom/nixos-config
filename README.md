# NixOS configuration
Here is my NixOS and Home Manager configurations.
The configurations are provided as a flake and should currently be considered work in progress.

## Building NixOS
To build the NixOS configuration located in ```nixos/``` run the following command:

```shell
sudo nixos-rebuild --flake . switch
```

## Building home
To build the home manager configuration located in ```home-manager/``` run the following command:

```shell
home-manager --flake . switch
```
