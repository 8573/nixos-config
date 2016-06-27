{ config, lib, pkgs, ... }: {

  hardware.enableAllFirmware = config.c74d-params.enable-all-firmware;

  hardware.sane = {
    enable = config.c74d-params.installation-type != "server";
    extraBackends = with pkgs; [
      hplip
    ];
  };

}
