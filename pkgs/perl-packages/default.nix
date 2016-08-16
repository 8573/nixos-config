{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    call-pkg;

in

with pkgs.perlPackages;

rec {

}
