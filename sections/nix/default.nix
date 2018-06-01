{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    mk-if-TZ-is-UTC;

in {

  nix = {
    gc = {
      automatic = true;
      dates =
        mk-if-TZ-is-UTC
          "03:15 ${config.c74d-params.location.target.timezone}";
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
