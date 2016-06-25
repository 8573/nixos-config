{ config, lib, pkgs, ... }: {

  imports = [
    ./etc
    ./system-packages
  ];

  environment.extraInit = ''
    umask 077
  '';

}
