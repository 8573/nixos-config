{ config, lib, pkgs, ... }: rec {

  not-empty-str = lib.ne "";

  str-contains-any = needles: haystack:
    let
      needles' = map toString needles;
      empties = map (lib.const "") needles;
      haystack' = toString haystack;
    in
      assert lib.all not-empty-str needles';
      lib.replaceStrings needles' empties haystack' != haystack';

  str-contains-none = needles: haystack:
    !(str-contains-any needles haystack);

}
