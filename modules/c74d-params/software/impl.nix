{ config, lib, pkgs, ... }: let

  get-sw-module = lib.flip lib.getAttrFromPath config.c74d-params.software;

in {

  config.lib.c74d.mk-software-module = {
    path,
    name,
    sw,
    default #? (get-sw-module (lib.init path)).enable,
  }:
    /*let
      enabling-condition =
        lib.foldl enabling-cond-inner [] path != false;

      enabling-cond-inner =
        acc: val:
          if acc == false then
            false
          else
            assert lib.isList acc;
            let
              path-step = acc ++ [val];
              enabled = lib.getAttrFromPath
                (path-step ++ ["enable"])
                config.c74d-params.software;
            in
              if enabled then
                path-step
              else
                false;
    in*/
      assert lib.isList path;
      assert lib.length path >= 1;
      assert lib.all lib.isString path;
      assert lib.isString name;
      assert lib.isFunction sw;
      assert lib.isBool default;
    {
      /*options.c74d-params.software =
        lib.setAttrByPath (path ++ ["enable"]) (lib.mkOption {
          type = lib.types.bool;
          inherit default;
          description = ''
            Whether to include ${name} in the set of system packages.
          '';
        });

      config.environment.systemPackages =
        lib.mkIf
          false #(get-sw-module path).enable
          #(sw (lib.recursiveUpdate pkgs config.lib.c74d.pkgs));
          (sw pkgs);*/
    };

}
