{ config, lib, pkgs, ... }: {

  imports = [
    ./audio-and-video
    ./files
    ./google
    ./hardware
    ./misc
    ./monitoring
    ./network
    ./security-and-crypto
    ./X11
  ];

}
