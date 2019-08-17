{ config, lib, pkgs, ... }: let

  loc = config.c74d-params.location.target;

in {

  services.redshift = {
    enable = config.services.xserver.enable && config.c74d-params.personal;
    temperature = {
      night = 6500 / 3;
    };
  };

  systemd.user.services.redshift = {
    environment = {
      TZ = loc.timezone;
    };
  };

}
