{ config, lib, pkgs, ... }: let

  enable-NetworkManager = lib.elem config.c74d-params.installation-type [
  ];

  enable-WiFi = config.c74d-params.Wi-Fi.enable;

  enable-wpa_supplicant = enable-WiFi && !enable-NetworkManager;

  DNS-nameservers = with config.lib.c74d.DNS.nameservers;
    Quad9 ++ Google-Public-DNS;

in {

  networking.resolvconf = {
    # [2020-09-01] NOTE: This may need to be overridden to get DNS access
    # behind some routers or other such devices:
    # <https://github.com/NixOS/nixpkgs/issues/24433>.
    dnsExtensionMechanism = true;
  };

  networking.hostId = config.c74d-params.id8;

  networking.hostName = lib.mkDefault config.c74d-params.id5;

  networking.nameservers =
    lib.mkIf (!enable-NetworkManager) DNS-nameservers;

  networking.networkmanager = lib.mkIf enable-NetworkManager {
    enable = true;
    insertNameservers = DNS-nameservers;
  };

  networking.wireless = lib.mkIf enable-wpa_supplicant {
    # Enables wireless support via wpa_supplicant.
    enable = true;
  };

  services.resolved = {
    fallbackDns = DNS-nameservers;
  };

}
