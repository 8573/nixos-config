{ config, lib, pkgs, ... }: let

  mk-software-module-hierarchy = root-modl-src-path:
    let
      root-ir = mk-software-module-IR {} (import root-modl-src-path);
      something = loop-fn {} {} root-ir;
    in {
      options.c74d-params =
        lib.mkMerge
          (...);
      config.environment.systemPackages =
        lib.mkMerge
          (...);
    };

  loop-fn = prev-state: parent-ir: ir:
    let
      sub-modules = map (loop-fn ir) ir.modules;
      enable-opt-path = ir.attr-path ++ ["enable"];
      state = {
        options-sets =
          lib.setAttrByPath
            enable-opt-path
            ir.option;
        pkgs-sets =
          lib.mkIf
            (lib.getAttrFromPath
              enable-opt-path
              config.c74d-params.software)
            ir.pkgs;
      };
    in
      ???;

  mk-software-module-IR = parent-ir: {
    id,
    name,
    default ? null,
    sw ? null,
    modules ? null,
  }:
    assert lib.isAttrs parent-ir;
    assert lib.isString id;
    assert lib.isString name;
    assert default != null -> lib.isBool default;
    assert modules != null -> sw == null;
    assert modules == null -> lib.isFunction sw;
    assert sw != null -> modules == null;
    assert sw == null -> lib.isList modules;
    let
      opt-default =
        if default != null then
          default
        else
          # TODO: Make this default to the parent's default.
          false;

      sw-pkgs =
        let
          value = sw pkgs;
        in
          lib.optionals
            (sw != null)
            (assert lib.isList value; value);

      sub-modules =
        let
          value = map import modules;
        in
          lib.optionals
            (modules != null)
            value;
    in {
      attr-path =
        (parent-ir.attr-path or []) ++ [id];

      option = lib.mkOption {
        type = lib.types.bool;
        default = opt-default;
        example = !opt-default;
        description = ''
          Whether to install ${name} as part of the set of system packages.
        '';
      };

      pkgs = sw-pkgs;

      modules = sub-modules;
    };

in
  mk-software-module-hierarchy
    /etc/nixos/software
