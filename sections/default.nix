{ config, lib, pkgs, ... }: {

  imports = [
    ./boot
    ./environment
    ./file-systems
    ./fonts
    ./hardware
    ./i18n
    ./location
    ./networking
    ./nix
    ./nixpkgs
    ./programs
    ./security
    ./services
    ./sound
    ./system
    ./systemd
    ./time
    ./users
    ./zram-swap
  ];

}
