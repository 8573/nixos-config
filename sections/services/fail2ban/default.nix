{ config, lib, pkgs, ... }: {

  services.fail2ban = {
    enable = lib.mkDefault true;

    jails = {
      ssh-iptables = ''
        enabled = true
      '';
    };
  };

}
