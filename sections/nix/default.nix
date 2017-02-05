{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    approx-target-local-time-hm-str;

in {

  nix = {
    gc = {
      automatic = true;
      dates =
        lib.mkIf
          (assert config.time ? timeZone;
            config.time.timeZone == "UTC")
          (approx-target-local-time-hm-str 3 15);
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
