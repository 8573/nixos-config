{ config, lib, pkgs, ... }: let

  mk-software-module-hierarchy = root-modl-src-path:
    let
      root-ir =
        mk-software-module-IR
          []
          (import root-modl-src-path);
      collected =
        collect-opts-and-pkgs
          collect-opts-and-pkgs-initial-state
          root-ir;
    in {
      options.c74d-params =
        lib.mkMerge
          collected.options;
      config.environment.systemPackages =
        lib.mkMerge
          collected.pkgs-cfg;
    };

  collect-opts-and-pkgs-initial-state = {
    options = [];
    pkgs-cfg = [];
  };

  collect-opts-and-pkgs = { options, pkgs-cfg }: ir:
    assert check-IR-invariants ir;
    if ir.modules == null then
      # We've hit a leaf node, our base case.
      { options = options ++ [ir.option];
        pkgs-cfg = pkgs-cfg ++ [ir.pkgs-cfg]; }
    else
      let
        state =
          { options = options ++ [ir.option];
            inherit pkgs-cfg; };
      in
        lib.foldl collect-opts-and-pkgs state ir.modules;

  check-IR-invariants = {
    option,
    pkgs-cfg,
    modules,
  }:
    assert lib.isAttrs option;
    assert modules != null -> pkgs-cfg == null;
    assert modules == null -> lib.isType "if" pkgs-cfg;
    assert pkgs-cfg != null -> modules == null;
    assert pkgs-cfg == null -> lib.isList modules;
    true;

  check-swmodule-invariants = {
    id,
    name,
    default ? null,
    sw ? null,
    modules ? null,
  }:
    assert lib.isString id;
    assert lib.isString name;
    assert default != null -> lib.isBool default;
    assert modules != null -> sw == null;
    assert modules == null -> lib.isFunction sw;
    assert sw != null -> modules == null;
    assert sw == null -> lib.isList modules;
    true;

  mk-software-module-IR = parent-attr-path: {
    id,
    name,
    default ? null,
    sw ? null,
    modules ? null,
  } @ this-swmodule:
    assert lib.isList parent-attr-path;
    assert lib.all lib.isString parent-attr-path;
    assert check-swmodule-invariants this-swmodule;
    let
      attr-path =
        parent-attr-path ++ [id];

      enable-opt-path =
        attr-path ++ ["enable"];

      opt-default =
        if default != null then
          default
        else
          # TODO: Make this default to the parent's default.
          false;

      option =
        lib.setAttrByPath
          enable-opt-path
          (lib.mkOption {
            type = lib.types.bool;
            default = opt-default;
            example = !opt-default;
            description = ''
              Whether to install ${name} as part of the set of system
              packages.
            '';
          });

      sw-pkgs =
        let
          value =
            sw
              (lib.recursiveUpdate
                pkgs
                config.lib.c74d.pkgs);
        in
          assert lib.isList value;
          value;

      pkgs-cfg =
        if sw == null then
          null
        else
          lib.mkIf
            (lib.getAttrFromPath
              enable-opt-path
              config.c74d-params)
            sw-pkgs;

      sub-modules =
        if modules == null then
          null
        else
          map
            (src-path:
              mk-software-module-IR
                attr-path
                (import src-path))
            modules;
    in {
      inherit option pkgs-cfg;

      modules = sub-modules;
    };

in
  mk-software-module-hierarchy
    /etc/nixos/software
