{ config, lib, pkgs, ... }: {

  security = {
    apparmor = {
      enable = true;
    };

    grsecurity = {
      enable = config.c74d-params.grsecurity.enable;
    };

    sudo = {
      enable = false;
    };
  };

}
