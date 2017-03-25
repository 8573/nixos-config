{ config, lib, pkgs, ... }: {

  imports = [
    ./git
    ./vim
  ];

  environment.etc."c74d/NixOS/c74d-params.json".text =
    builtins.toJSON
      (lib.filterAttrs
        (_: v: !(lib.isAttrs v))
        config.c74d-params);

}
