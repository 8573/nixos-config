{ config, lib, ... }: {

  nixpkgs.config.packageOverrides = pkgs: let
    inherit (pkgs.lib)
      overrideDerivation;
  in {

  } // lib.optionalAttrs config.environment.noXlibs {
    pinentry = pkgs.pinentry.override {
      gtk2 = null;
    };
  } // lib.optionalAttrs (!config.c74d-params.minimal) {
    diffoscope = pkgs.diffoscope.override {
      enableBloat = true;
    };
  };

}
