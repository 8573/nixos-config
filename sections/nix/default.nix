{ config, lib, pkgs, ... }: {

  nix = {
    gc = {
      automatic = true;
    };
    maxJobs = config.c74d-params.hw.cores.virtual;
    useSandbox = true;
    extraOptions = ''
      auto-optimise-store = true
      build-fallback = false
    '';
  };

}
