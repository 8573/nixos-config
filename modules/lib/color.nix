{ config, lib, pkgs, ... }: let

  inherit (lib.c74d) normalize-from;

in rec {

  # Takes a triple of RGB values each in [0, 255]
  #
  # The formula is taken from
  # <https://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef>.
  #
  # [2020-06-21] I wanted ultimately to compute the contrast ratios between
  # colors and select colors programmatically for their contrast (where one
  # color would be fixed, generated by some other means), but it seems that
  # this is hopeless because the formula requires exponentiation and
  # exponentiation in Nix is hopeless (unless it gets implemented as a builtin
  # function).
  #relative-luminance-8b = rgb-8b:
  #  assert lib.isList rgb-8b;
  #  assert lib.length rgb-8b == 3;
  #  let
  #    rgb-1 = map (normalize-from 0.0 255.0) rgb-8b;
  #    channel-map = c:
  #      if c <= 0.03928 then c / 12.92 else ((c + 0.055) / 1.055) ^ 2.4;

}
