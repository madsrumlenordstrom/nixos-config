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

## Testing the config
You can try this configuration in a virtual machine by running

```shell
nix run
```

This will boot a virtual machine with qemu where you can play around with this setup.

## Building ISO
If you want to get an ISO with this configuration run:

```shell
nix build
```

This builds the ISO image with a NixOS installer. You can flash it to a USB drive and boot a live environment of this setup.
