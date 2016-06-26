{ config, lib, pkgs, ... }: {

  hardware.enableAllFirmware = config.c74d-params.enable-all-firmware;

  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [
      hplip
    ];
  };

}
