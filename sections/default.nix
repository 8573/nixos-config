{ config, lib, pkgs, ... }: {

  imports = [
    ./boot
    ./environment
    ./hardware
    ./file-systems
    ./fonts
    ./i18n
    ./networking
    ./nix
    ./nixpkgs
    ./programs
    ./security
    ./services
    ./system
    ./systemd
    ./time
    ./users
    ./zram-swap
  ];

}
