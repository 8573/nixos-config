{ config, lib, pkgs, ... }: {

  security = {
    apparmor = {
      enable = true;
    };

    chromiumSuidSandbox = {
      enable = true;
    };

    hideProcessInformation = true;

    sudo = {
      enable = false;
    };
  };

}
