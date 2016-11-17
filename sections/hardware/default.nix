{ config, lib, pkgs, ... }: {

  hardware.enableAllFirmware = config.c74d-params.enable-all-firmware;

  hardware.sane = {
    enable = config.c74d-params.installation-type != "server" && false;
    extraBackends = lib.mkIf config.hardware.sane.enable (with pkgs; [
      hplip
    ]);
  };

}
