{ config, lib, pkgs, ... }: rec {

  DNS.nameservers = {
    Google-Public-DNS = [
      "8.8.8.8"
      "2001:4860:4860::8888"
      "8.8.4.4"
      "2001:4860:4860::8844"
    ];

    # I doubt this network of nameservers offered by IBM et al. is as fast as
    # Google's, but it claims the additional feature of blocking malicious
    # domains.
    Quad9 = [
      "9.9.9.9"
      "2620:fe::fe"
      "149.112.112.112"
      "2620:fe::9"
    ];
  };

}
