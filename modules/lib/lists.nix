{ config, lib, pkgs, ... }: rec {

  list-is-empty = list:
    lib.length list == 0;

  elem-at-or = default: list: idx:
    if idx < lib.length list then
      lib.elemAt list idx
    else
      default;

  interleave-lists = list-of-lists:
    map
      ({e, ...}: e)
      (lib.sort
        (x: y: if x.i != y.i then x.i < y.i else x.n < y.n)
        (lib.concatLists (lib.imap0
          (n: lib.imap0 (i: e: {inherit e i n;}))
          list-of-lists)));

}
