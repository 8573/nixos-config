{ config, lib, pkgs, ... }: let

  loc = config.c74d-params.location.target;

in {

  services.redshift = {
    latitude = toString loc.latitude;
    longitude = toString loc.longitude;
    temperature = {
      night = 1850;
    };
  };

  systemd.user.services.redshift.environment =
    lib.mkIf (config.services.xserver.display == null) (lib.mkForce {
      DISPLAY = ":0";
    });

}
