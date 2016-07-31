{ config, lib, pkgs, ... }: {

  lib.c74d.call-pkg = sub-path: args:
    assert lib.isString sub-path;
    assert lib.isAttrs args;
    let
      path-str = "${toString ./.}/${sub-path}";
      path = builtins.toPath path-str;
    in
      lib.callPackageWith pkgs path args;

}
