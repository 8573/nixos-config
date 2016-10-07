{ config, lib, pkgs, ... }: {

  imports = [
    ./basic
    ./extra
    ./devel
    ./X11
  ];

}
