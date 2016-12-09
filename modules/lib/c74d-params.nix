{ config, lib, pkgs, ... }: let

  inherit (config)
    c74d-params;

in rec {

  mk-if-minimal =
    lib.mkIf c74d-params.minimal;

  mk-if-non-minimal =
    lib.mkIf (!c74d-params.minimal);

}
