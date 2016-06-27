{ config, lib, pkgs, ... }: {

  imports = [
    ./etc
    ./system-packages
    ./variables
  ];

  environment.extraInit = ''
    umask 077
  '';

  environment.noXlibs = !config.c74d-params.X11.enable;

}
