{ config, lib, pkgs, ... }: {

  imports = [
    ./boot
    ./environment
    ./file-systems
    ./fonts
    ./hardware
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
