{ config, lib, options, pkgs, ... }: {

  services.zfs = {
    autoSnapshot = {
      enable = config.c74d-params.usually-up;
      flags = "${options.services.zfs.autoSnapshot.flags.default} --utc";
      monthly = 1;
    };
  };

}
