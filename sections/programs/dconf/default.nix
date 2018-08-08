{ config, lib, pkgs, ... }: {

  programs.dconf = lib.mkIf (
    !config.c74d-params.minimal
  ) {
    enable = true;
  };

}
