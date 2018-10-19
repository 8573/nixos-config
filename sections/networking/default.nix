{ config, lib, pkgs, ... }: let

  enable-NetworkManager = lib.elem config.c74d-params.installation-type [
    "laptop"
  ];

  enable-WiFi = lib.elem config.c74d-params.installation-type [
    "desktop"
  ];

  enable-wpa_supplicant = enable-WiFi && !enable-NetworkManager;

  Google-Public-DNS-nameservers = [
    "8.8.8.8"
    "2001:4860:4860::8888"
    "8.8.4.4"
    "2001:4860:4860::8844"
  ];

in {

  networking.dnsExtensionMechanism = true;

  networking.hostId = config.c74d-params.id8;

  networking.hostName = lib.mkDefault config.c74d-params.id5;

  networking.nameservers =
    lib.mkIf (!enable-NetworkManager) Google-Public-DNS-nameservers;

  networking.networkmanager = lib.mkIf enable-NetworkManager {
    enable = true;
    insertNameservers = Google-Public-DNS-nameservers;
  };

  networking.wireless = lib.mkIf enable-wpa_supplicant {
    # Enables wireless support via wpa_supplicant.
    enable = true;
  };

}
