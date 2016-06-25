{ config, lib, pkgs, ... }: {

  imports = [
    ./boot
    ./environment
    ./hardware
    ./fonts
    ./networking
    ./nix
    ./programs
    ./security
    ./services
    ./system
    ./time
    ./users
    ./zram-swap
  ];

}
