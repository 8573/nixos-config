{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    alsaUtils
    lshw
    pciutils
    smartmontools
    usbutils
  ]);

}
