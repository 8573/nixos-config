{ config, lib, pkgs, ... }: {

  services.xserver = {
    enable = !config.environment.noXlibs;

    desktopManager = {
      xterm.enable = false;
    };

    xkbOptions = "compose:caps";
  };

}
