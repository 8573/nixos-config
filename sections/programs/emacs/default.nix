{ config, lib, pkgs, ... }: let

  # ...

in {

  imports = [
    #./personal.nix
  ];

  programs.emacs = {
    enable = lib.mkDefault (!config.c74d-params.minimal);

    daemon = lib.mkDefault (!config.c74d-params.minimal);
  };

}
