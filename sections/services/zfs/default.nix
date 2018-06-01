{ config, lib, options, pkgs, ... }: let

  inherit (config.c74d-params.location.target)
    timezone;

in {

  services.zfs = {
    autoScrub = {
      enable = config.c74d-params.usually-up;

      # Scrub twice per year, on the first Thursdays of May and November, at
      # 02:00 local time. (The default is to scrub every Sunday at 02:00
      # system time.)
      interval = "Thu *-05,11-01..07 02:00 ${timezone}";
    };

    autoSnapshot = {
      enable = config.c74d-params.usually-up;
      flags = "${options.services.zfs.autoSnapshot.flags.default} --utc";
      monthly = 1;
    };
  };

}
