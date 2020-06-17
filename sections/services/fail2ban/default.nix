{ config, lib, pkgs, ... }: {

  services.fail2ban = {
    enable = lib.mkDefault (
      config.services.openssh.enable
    );

    jails = {
      ssh-iptables = ''
        enabled = true
      '';
    };
  };

}
