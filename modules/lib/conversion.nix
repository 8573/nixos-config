{ config, lib, pkgs, ... }: {

  floatOfInt = int:
    assert lib.isInt int;
    builtins.fromJSON "${toString int}.0";

}
