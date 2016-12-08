{ config, lib, pkgs, ... }: rec {

  eq = x: y: x == y;
  ge = x: y: x >= y;
  gt = x: y: x > y;
  le = x: y: x <= y;
  lt = x: y: x < y;
  ne = x: y: x != y;

}
