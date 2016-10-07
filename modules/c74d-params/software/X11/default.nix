{ config, lib, pkgs, ... }: {

  imports = [
    ./tools
  ];

  options.c74d-params.software.X11.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = config.c74d-params.X11.enable;
    };

}
