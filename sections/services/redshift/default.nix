{ config, lib, pkgs, ... }: {

  services.redshift = {
    # Home
    latitude = "34";
    longitude = "-118";
    # Conf-US-CO-GE
    #latitude = "39";
    #longitude = "-105";
    # Conf-US-NC-Gy
    #latitude = "36";
    #longitude = "-80";
    temperature = {
      night = 1850;
    };
  };

}
