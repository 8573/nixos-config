{ config, lib, pkgs, ... }: {

  imports = [
    ./common
    ./non-X11-only
    ./X11-only
  ];

}
