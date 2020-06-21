{ config, lib, pkgs, ... } @ module-args: let

  libs-srcs = [
    ./trivial.nix
    ./conversion.nix
    ./strings.nix
    ./math.nix
    ./date-and-time.nix
    ./c74d-params.nix
    ./color.nix
  ];

  libs =
    map
      mk-lib
      libs-srcs;

  mk-lib = src:
    let
      module-args' =
        module-args
        // { lib = lib.recursiveUpdate lib config.lib.c74d; };
    in
      { lib.c74d = import src module-args'; };

in
  lib.mkMerge libs
