{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    call-pkg;

in {

  chromium = call-pkg ./chromium {};

  i3lock = call-pkg ./i3lock {};

}
