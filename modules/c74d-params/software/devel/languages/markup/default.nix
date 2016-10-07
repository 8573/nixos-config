{ config, lib, pkgs, ... }: {

  imports = [
    ./swim
  ];

  options.c74d-params.software.devel.languages.markup.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = config.c74d-params.software.devel.languages.enable;
    };

}
