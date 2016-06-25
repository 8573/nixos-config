{ config, lib, pkgs, ... }: {

  security = {
    apparmor = {
      enable = true;
    };
  };

}
