{ config, lib, pkgs, ... }: {

  programs.mosh = {
    enable = lib.mkDefault (!config.c74d-params.minimal);
  };

}
