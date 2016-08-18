{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    call-pkg;

in {

  i3lock = call-pkg ./i3lock {};

}
