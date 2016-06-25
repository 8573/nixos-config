{ config, lib, pkgs, ... }: {

  services.redshift = {
    latitude = "34";
    longitude = "-118";
    temperature = {
      night = 1850;
    };
  };

}
