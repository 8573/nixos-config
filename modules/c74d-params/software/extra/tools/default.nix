{ config, lib, pkgs, ... }: {

  options.c74d-params.software.extra.tools.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = config.c74d-params.software.extra.enable;
    };

  config.environment.systemPackages = lib.mkIf
    config.c74d-params.software.extra.tools.enable
    ((with pkgs; [
      alsaUtils
      aspell
      drive
      (lib.getBin imagemagick)
      (lib.getBin libav)
      (lib.getBin libqalculate)
      pdfdiff
    ]) ++ (with config.lib.c74d.pkgs; [
      agrep
    ]));

}
