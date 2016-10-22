{ config, lib, pkgs, ... }: {

  system = {
    # The NixOS release to be compatible with for stateful data such as
    # databases.
    stateVersion = "16.03";

    autoUpgrade = {
      enable = config.c74d-params.usually-up;
      channel =
        "https://nixos.org/channels/nixos-${
          { desktop = "unstable";
            laptop = "unstable";
            server = "unstable-small"; }
          .${config.c74d-params.installation-type}
        }";
      dates =
        lib.mkIf
          (assert config.time ? timeZone;
            config.time.timeZone == "UTC")
          "11:40";
      flags = [
        "-I" "AUTO-BUILD-FLAG=/dev/null/AUTO-BUILD-FLAG"
      ];
    };
  };

}
