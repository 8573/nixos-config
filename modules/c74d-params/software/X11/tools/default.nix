{ config, lib, pkgs, ... }: {

  options.c74d-params.software.X11.tools.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = config.c74d-params.software.X11.enable;
    };

  config.environment.systemPackages = lib.mkIf
    config.c74d-params.software.X11.tools.enable
    ((with pkgs; [
      redshift
      xclip
      xorg.xbacklight
      xorg.xev
      xorg.xmodmap
    ]));

}
