{ config, lib, pkgs, ... }: {

  options.c74d-params.software.X11.tools.i3.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = config.c74d-params.i3.enable;
    };

  config.environment.systemPackages = lib.mkIf
    config.c74d-params.software.X11.tools.i3.enable
    ((with config.lib.c74d.pkgs; [
      wrapped.i3lock
    ]));

}
