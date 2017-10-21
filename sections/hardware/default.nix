{ config, lib, pkgs, ... }: {

  hardware.enableRedistributableFirmware =
    config.c74d-params.enable-most-firmware;

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
