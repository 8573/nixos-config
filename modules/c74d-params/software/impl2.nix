{ config, lib, pkgs, ... } @ module-args: let

  inherit (config.lib.c74d)
    mk-if-non-minimal;

  mk-software-module-hierarchy = root-modl-src-path:
    let
      root-ir =
        mk-software-module-IR
          {}
          ["c74d-params"]
          (import root-modl-src-path);
      collected =
        collect-opts-and-pkgs
          collect-opts-and-pkgs-initial-state
          root-ir;
      extra-deps-of-cfg = cfg:
        let
          extra-deps = cfg.system.extraDependencies or [];
        in
          assert lib.isList extra-deps;
          extra-deps;
      extra-deps-of-if = { _type, condition, content }:
        assert _type == "if";
        lib.optionals
          condition
          (extra-deps-of-cfg content);
      pkg-list =
        lib.concatMap
          extra-deps-of-if
          collected.pkgs-cfg;
      extra-bin =
        collect-extra-bin
          pkg-list;
      extra-share =
        collect-extra-share
          pkg-list;
      cfgs =
        collected.pkgs-cfg ++ [
          { environment.etc."c74d/NixOS/sw/extraDependencies" = {
              enable = !config.c74d-params.minimal;
              source = extra-bin;
          }; }
          { environment.systemPackages =
              mk-if-non-minimal
                [extra-share]; }
        ];
    in {
      options =
        collected.options;
      config =
        lib.mkMerge
          cfgs;
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

  collect-extra-bin = pkg-list:
    pkgs.buildEnv {
      name = "c74d-extraDependencies-bin";
      paths = pkg-list;
      ignoreCollisions = true;
      pathsToLink = [
        "/bin"
      ];
    };

  collect-extra-share = pkg-list:
    pkgs.buildEnv {
      name = "c74d-extraDependencies-docs";
      paths = pkg-list;
      ignoreCollisions = true;
      pathsToLink = [
        "/share/doc"
        "/share/info"
        "/share/man"
      ];
      extraOutputsToInstall = ["doc"];
    };

  check-IR-invariants = {
    option,
    pkgs-cfg,
    global-computed,
    ignore-broken-pkgs-computed,
    modules,
  }:
    assert lib.isAttrs option;
    assert modules == null -> lib.isType "if" pkgs-cfg;
    assert pkgs-cfg == null -> lib.isList modules;
    true;

  check-swmodule-invariants = {
    id,
    desc,
    default ? null,
    global ? null,
    ignore-broken-pkgs ? null,
    sw ? null,
    modules ? null,
  }:
    assert lib.isString id;
    assert lib.isString desc;
    assert default != null -> lib.isBool default || lib.isFunction default;
    assert global != null -> lib.isBool global || lib.isFunction global;
    assert ignore-broken-pkgs != null ->
      lib.isBool ignore-broken-pkgs || lib.isFunction ignore-broken-pkgs;
    assert modules == null -> lib.isFunction sw;
    assert sw == null -> lib.isList modules;
    true;

  mk-software-module-IR = parent-ir: parent-attr-path: {
    id,
    desc,
    default ? null,
    global ? null,
    ignore-broken-pkgs ? null,
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

      compute-default = immed-val: default:
        if lib.isBool immed-val then
          immed-val
        else if lib.isFunction immed-val then
          let
            args = module-args // {
              parent =
                lib.getAttrFromPath
                  parent-attr-path
                  config;
            };
            value = immed-val args;
          in
            assert lib.isBool value;
            value
        else
          default;

      opt-default =
        compute-default
          default
          (lib.getAttrFromPath
            (parent-attr-path ++ ["enable"])
            config);

      global-computed =
        compute-default
          global
          parent-ir.global-computed;

      ignore-broken-pkgs-computed =
        compute-default
          ignore-broken-pkgs
          parent-ir.ignore-broken-pkgs-computed;

      option =
        lib.setAttrByPath
          enable-opt-path
          (lib.mkOption {
            type = lib.types.bool;
            default = opt-default;
            description = if global-computed then ''
              Whether to install ${desc} as part of the set of system
              packages.
            '' else ''
              Whether to keep ${desc} in the Nix store.
            '';
          });

      sw-pkgs =
        let
          value =
            sw
              (lib.recursiveUpdate
                pkgs
                config.lib.c74d.pkgs);
          filter-predicate = pkg:
            # If `ignore-broken-pkgs-computed == true`, then ignore (i.e.,
            # filter out) broken packages.
            ignore-broken-pkgs-computed -> !(pkg.meta.broken or false)
            ;
        in
          assert lib.isList value;
          lib.filter filter-predicate value;

      pkgs-cfg =
        if sw == null then
          null
        else
          lib.mkIf
            (lib.getAttrFromPath
              enable-opt-path
              config)
            pkgs-cfg-inner;

      pkgs-cfg-inner =
        if global-computed then {
          environment.systemPackages =
            map lib.getBin sw-pkgs
            ++ lib.optionals
              (!config.c74d-params.minimal)
              (map (lib.getOutput "doc") sw-pkgs);
        } else {
          system.extraDependencies =
            sw-pkgs;
        };

      sub-modules =
        if modules == null then
          null
        else
          map
            (src-path:
              mk-software-module-IR
                ir-result
                attr-path
                (import src-path))
            modules;

      ir-result = {
        inherit
          option
          pkgs-cfg
          ignore-broken-pkgs-computed
          global-computed;

        modules = sub-modules;
      };
    in
      ir-result;

in
  mk-software-module-hierarchy
    /etc/nixos/software
