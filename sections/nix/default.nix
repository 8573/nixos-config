{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    approx-target-local-time-hm-str
    mk-if-TZ-is-UTC;

in {

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic =
        { desktop = true;
          laptop = false;
          server = true;
          VM = true; }
        .${config.c74d-params.installation-type}
        && config.c74d-params.manages-own-store;
      dates =
        # [2020-06-02] The default time is 03:15, but I move it earlier so
        # that, if this must wake me with its disk churn, it wakes me nearer
        # midnight, when there's less light outside and returning to sleep is
        # easier.
        "Wed *~05..11 ${approx-target-local-time-hm-str 2 0}";
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
