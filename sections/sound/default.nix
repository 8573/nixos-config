{ config, lib, pkgs, ... }: {

  sound.enable = with config.c74d-params; X11.enable && !minimal;

}
