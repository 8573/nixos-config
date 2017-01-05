{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    approx-target-local-time-h;

in {

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
            server = "unstable-small";
            VM = "unstable"; }
          .${config.c74d-params.installation-type}
        }";
      dates =
        let
          hour =
            approx-target-local-time-h 4;
          value =
            "${toString hour}:40";
        in
          lib.mkIf
            (assert config.time ? timeZone;
              config.time.timeZone == "UTC")
            value;
      flags = [
        "-I" "AUTO-BUILD-FLAG=/dev/null/AUTO-BUILD-FLAG"
      ];
    };
  };

}
