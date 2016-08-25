{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    alsaUtils
    lshw
    lsscsi
    pciutils
    smartmontools
    usbutils
  ]);

}
