{ host-module-args }:

let

  inherit (host-module-args)
    lib;

  build-VM = configuration:
    (import <nixpkgs/nixos> {
      inherit configuration;
    }).vm;

  host-cfg =
    import <nixos-config> host-module-args;

  base-cfg =
    host-cfg // {
      imports =
        lib.remove
          local-inst-cfg-path
          host-cfg.imports;
    };

  local-inst-cfg-path =
    /.. + local-inst-cfg-path-str;

  local-inst-cfg-path-str =
    lib.removeSuffix "/configuration.nix" (toString <nixos-config>)
    + "/installations/local/configuration.nix";

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
