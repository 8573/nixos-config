{ config, lib, pkgs, ... }: {

  hardware.enableAllFirmware = config.c74d-params.enable-all-firmware;

  hardware.pulseaudio = {
    enable = lib.mkDefault
      (!config.environment.noXlibs && !config.c74d-params.minimal);
  };

  hardware.sane = {
    enable = lib.elem config.c74d-params.installation-type [
      "desktop"
      "laptop"
    ];
    extraBackends = lib.mkIf config.hardware.sane.enable (with pkgs; [
      hplip
    ]);
  };

}
