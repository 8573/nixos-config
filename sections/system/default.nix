{ config, lib, pkgs, ... }: {

  system = {
    # The NixOS release to be compatible with for stateful data such as
    # databases.
    stateVersion = "16.03";

    autoUpgrade = {
      enable = config.c74d-params.usually-up;
      dates =
        lib.mkIf
          (assert config.time ? timeZone;
            config.time.timeZone == "UTC")
          "11:40";
    };
  };

}
