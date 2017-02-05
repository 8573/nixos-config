{ config, lib, pkgs, ... }: {

  nix = {
    gc = {
      automatic = true;
    };
    maxJobs =
      lib.mkIf
        config.c74d-params.manages-own-store
        config.c74d-params.hardware.cores.virtual;
    useSandbox = true;
    extraOptions = ''
      auto-optimise-store = true
    '';
  };

}
