{ config, lib, pkgs, ... }: {

  imports = [
    ./audio-and-video
    ./files
    ./google
    ./hardware
    ./misc
    ./monitoring
    ./network
    ./pdf
    ./security-and-crypto
    ./typesetting
    ./X11
  ];

}
