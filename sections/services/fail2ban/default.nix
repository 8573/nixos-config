{ config, lib, pkgs, ... }: {

  services.fail2ban = {
    enable = true;

    jails = {
      ssh-iptables = ''
        enabled = true
      '';
    };
  };

}
