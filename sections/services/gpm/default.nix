{ config, lib, pkgs, ... }: {

  services.gpm = {
    enable = lib.mkDefault (!config.c74d-params.minimal);
  };

}
