{ config, lib, pkgs, ... }: {

  imports = [
    ./markup
  ];

  options.c74d-params.software.devel.languages.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = config.c74d-params.software.devel.enable;
    };

}
