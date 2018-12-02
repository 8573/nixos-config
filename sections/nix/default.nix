{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    approx-target-local-time-hm-str
    mk-if-TZ-is-UTC;

in {

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates =
        "Wed *~05..11 ${approx-target-local-time-hm-str 3 15}";
    };
    maxJobs =
      lib.mkIf
        config.c74d-params.manages-own-store
        config.c74d-params.hardware.cores.virtual;
    useSandbox = true;
    extraOptions = ''
      max-silent-time = 3600
    '';
  };

}
