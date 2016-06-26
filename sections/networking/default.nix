{ config, lib, pkgs, ... }: {

  networking.hostId = config.c74d-params.id8;

  networking.hostName = config.c74d-params.id5;

  networking.nameservers = [
    "8.8.8.8"
    "2001:4860:4860::8888"
    "8.8.4.4"
    "2001:4860:4860::8844"
  ];

  networking.wireless = {
    # Enables wireless support via wpa_supplicant.
    enable = true;
  };

}
