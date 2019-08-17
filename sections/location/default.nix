{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d) floatOfInt;

  loc = config.c74d-params.location.target;

in {

  location = {
    latitude = floatOfInt loc.latitude;
    longitude = floatOfInt loc.longitude;
  };

}
