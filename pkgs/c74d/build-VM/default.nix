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

  template = template-cfg: input-cfg:
    build-VM {
      imports = [
        generic-configuration-path
        ./vm-cfg
        template-cfg
        input-cfg
      ];
    };

in {
  basic = template {};
}
