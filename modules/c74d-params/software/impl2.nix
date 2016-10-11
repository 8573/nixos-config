{ config, lib, pkgs, ... } @ module-args: let

  mk-software-module-hierarchy = root-modl-src-path:
    let
      root-ir =
        mk-software-module-IR
          ["c74d-params"]
          (import root-modl-src-path);
      collected =
        collect-opts-and-pkgs
          collect-opts-and-pkgs-initial-state
          root-ir;
    in {
      options =
        collected.options;
      config =
        lib.mkMerge
          collected.pkgs-cfg;
    };

  collect-opts-and-pkgs-initial-state = {
    options = {};
    pkgs-cfg = [];
  };

  collect-opts-and-pkgs = { options, pkgs-cfg }: ir:
    assert check-IR-invariants ir;
    let
      options' =
        lib.recursiveUpdate
          options
          ir.option;

      pkgs-cfg' =
        if ir.pkgs-cfg == null then
          pkgs-cfg
        else
          pkgs-cfg ++ [ir.pkgs-cfg];

      state =
        { options = options';
          pkgs-cfg = pkgs-cfg'; };
    in
      if ir.modules == null then
        state
      else
        lib.foldl collect-opts-and-pkgs state ir.modules;

  check-IR-invariants = {
    option,
    pkgs-cfg,
    modules,
  }:
    assert lib.isAttrs option;
    assert modules == null -> lib.isType "if" pkgs-cfg;
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
    assert default != null -> lib.isBool default || lib.isFunction default;
    assert modules == null -> lib.isFunction sw;
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
        if lib.isBool default then
          default
        else if lib.isFunction default then
          let
            value = default module-args;
          in
            assert lib.isBool value;
            value
        else
          lib.getAttrFromPath
            (parent-attr-path ++ ["enable"])
            config;

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
              config)
            { environment.systemPackages = sw-pkgs; };

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
