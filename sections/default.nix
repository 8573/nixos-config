{ config, lib, pkgs, ... }: {

  imports = [
    ./boot
    ./environment
    ./hardware
    ./file-systems
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
