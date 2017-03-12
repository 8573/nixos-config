{ config, lib, ... }: {

  nixpkgs.config.packageOverrides = pkgs: let
    inherit (pkgs.lib)
      overrideDerivation;
  in {

  } // lib.optionalAttrs config.environment.noXlibs {
    pinentry = pkgs.pinentry.override {
      gtk2 = null;
    };
  };

}
