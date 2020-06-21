{ config, lib, pkgs, ... }: rec {

  number-is-int = n:
    builtins.match ''^[0-9]+\.?0*$'' (toString n) != null;

  # I make no guarantee as to whether the result is a float or int.
  integer-part = n:
    let
      m = builtins.match ''^([0-9]+)\.?[0-9]*$'' (toString n);
    in
      if m == null then
        throw "value passed to `lib.c74d.integerPart` is not a number"
      else
        builtins.fromJSON (lib.head m);

  map-range = old-min: old-max: new-min: new-max: n:
    (n - old-min)
    * (new-max - new-min)
    / (old-max - old-min)
    + new-min;

  normalize-from = old-min: old-max: n:
    map-range old-min old-max 0 1 n;

  # [2020-06-21] This is hopeless!  I thought to represent a rational exponent
  # as an integer numerator and an integer denominator and use the identity
  # `b^(n m) = (b^n)^m', but, taking this route, I would need to take roots,
  # which Nix also can't do!
  #power = base: exponent:
  #  let
  #    pos-int-exponent-power = exponent: acc:
  #      if exponent == 1 then
  #        acc
  #      else
  #        pos-int-exponent-power (exponent - 1) (acc * base);
  #    int-exponent-power = exponent: acc:
  #      if exponent > 0 then
  #        pos-int-exponent-power exponent acc
  #      else if exponent < 0 then
  #        1.0 / (pos-int-exponent-power (-exponent) acc)
  #      else if base != 0 then
  #        1
  #      else
  #        throw "raising zero to the zeroth power";
  #  in
  #    if number-is-int exponent then
  #      int-exponent-power (exponent - 1) base;
  #    else
  #      with-float-as-ratio ...;
  #
  #with-float-as-ratio = n: callback:
  #  let
  #    # Find an integer `m' such that `n * m' is an integer.
  #    m = multiply-until-satisfying 8 2 (m: number-is-int (n * m));
  #  in
}
