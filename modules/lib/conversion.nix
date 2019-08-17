{ config, lib, pkgs, ... }: {

  floatOfInt = int:
    assert lib.isInt int;
    int * 1.0;

}
