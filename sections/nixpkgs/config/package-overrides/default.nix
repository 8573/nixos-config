{ config, lib, ... }: {

  nixpkgs.config.packageOverrides = pkgs: let
    inherit (pkgs.lib)
      overrideDerivation;
  in {

  };

}
