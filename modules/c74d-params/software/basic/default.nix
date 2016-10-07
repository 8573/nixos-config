{ config, lib, pkgs, ... }: {

  imports = [
    ./tools
  ];

  options.c74d-params.software.basic.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

}
