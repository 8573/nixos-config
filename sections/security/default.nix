{ config, lib, pkgs, ... }: {

  security = {
    apparmor = {
      enable = true;
    };

    hideProcessInformation = true;

    sudo = {
      enable = false;
    };
  };

}
