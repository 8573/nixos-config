{ config, lib, pkgs, ... }: let

  loc = config.c74d-params.location.target;

in {

  services.redshift = {
    enable = config.services.xserver.enable && config.c74d-params.personal;
    latitude = toString loc.latitude;
    longitude = toString loc.longitude;
    temperature = {
      night = 6500 / 3;
    };
  };

}
