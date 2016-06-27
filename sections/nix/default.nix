{ config, lib, pkgs, ... }:

let

  half-the-cores =
    builtins.div (config.c74d-params.hw.cores or 2) 2;

in {

  nix = {
    buildCores = half-the-cores;
    gc = {
      automatic = true;
    };
    maxJobs = half-the-cores;
    useSandbox = true;
    extraOptions = ''
      auto-optimise-store = true
      build-fallback = false
    '';
  };

}
