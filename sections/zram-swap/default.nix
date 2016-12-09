{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    mk-if-non-minimal;

in {

  zramSwap = {
    enable = mk-if-non-minimal true;
  };

}
