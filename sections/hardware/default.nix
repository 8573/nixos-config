{ config, lib, pkgs, ... }: let

  CPU-both = {
    # (2020-06-20) I left the microcode un-updated for years because I
    # disliked the thought of letting my OS mess with something so important,
    # but apparently microcode updates are required to mitigate some CPU
    # vulnerabilities ("MDS" and "Speculative Store Bypass"). Apparently there
    # is a risk of the kernel hanging at boot if Intel pushes a buggy
    # microcode update, though. If that happens, I should be able to roll
    # back, though.
    updateMicrocode = true;
  };

  CPU-Intel = CPU-both;

  CPU-AMD = CPU-both;

in {

  hardware.cpu = {
    AMD = {amd = CPU-AMD;};
    Intel = {intel = CPU-Intel;};
    "(virtual)" = {};
  }.${config.c74d-params.hardware.main-CPU-mfr};

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
