{ host-module-args }:

let

  inherit (host-module-args)
    lib;

  inherit (host-module-args.config.lib.c74d)
    generic-configuration-path;

  build-VM = configuration:
    (import <nixpkgs/nixos> {
      inherit configuration;
    }).vm;

  exported-host-cfg = {
    c74d-params.VM.host = {
      inherit (host-module-args)
        config;
    };
  };

  template = template-cfg: input-cfg:
    build-VM {
      imports = [
        generic-configuration-path
        exported-host-cfg
        ./vm-cfg
        template-cfg
        input-cfg
      ];
    };

in {
  basic = template {};
}
