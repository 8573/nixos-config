{ config, lib, pkgs, ... } @ args: {

  config = lib.mkIf config.c74d-params.hardened-profile (
    import <nixpkgs/nixos/modules/profiles/hardened.nix> args
  );

}
