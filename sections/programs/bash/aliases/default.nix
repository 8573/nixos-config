{ config, lib, pkgs, ... }: {

  imports = [
    ./coreutils.nix
    ./bluetooth.nix
  ];

}
