{ config, lib, pkgs, ... }: {

  imports = [
    ./etc
    ./variables
  ];

  environment.extraInit = ''
    umask 077
  '';

  environment.noXlibs = !config.c74d-params.X11.enable;

}
