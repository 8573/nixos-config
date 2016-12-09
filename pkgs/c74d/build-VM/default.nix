{ host-module-args }:

let

  inherit (host-module-args)
    lib;

  inherit (host-module-args.config.lib.c74d)
    str-contains-none;

  build-VM = configuration:
    (import <nixpkgs/nixos> {
      inherit configuration;
    }).vm;

  host-cfg =
    import <nixos-config> host-module-args;

  base-cfg =
    host-cfg // {
      imports =
        lib.filter
          host-cfg-imports-filter
          host-cfg.imports;
    };

  host-cfg-imports-filter =
    str-contains-none [
      "local"
      "secret"
    ];

  template = template-cfg: input-cfg:
    build-VM (
      { config, lib, pkgs, ... } @ args:
      base-cfg // {
        imports = base-cfg.imports ++ [
          ./vm-cfg
          input-cfg
        ];
      }
    );

in {
  basic = template {};
}
