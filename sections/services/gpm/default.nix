{ config, lib, pkgs, ... }: {

  services.gpm = {
    enable = lib.mkDefault (
      !config.c74d-params.minimal
      # [2020-06-17] I never use GPM, so all I get from it is the annoyance of
      # having my keyboard input interrupted if I bump the pointing device and
      # the potential attack surface of another service running.
      && false
    );
  };

}
