{ config, lib, pkgs, ... }: {

  imports = [
    ./languages
  ];

  options.c74d-params.software.extra.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = {
        desktop = true;
        laptop = true;
        server = false;
      }.${config.c74d-params.installation-type};
    };

}
