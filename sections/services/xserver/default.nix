{ config, lib, pkgs, ... }: {

  services.xserver = {
    enable = !config.environment.noXlibs;

    xkbOptions = "compose:caps";
  };

}
