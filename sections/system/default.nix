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
        let
          tz-offset =
            config.c74d-params.location.target.timezone-avg-offset;
          hour =
            assert tz-offset < 24;
            assert tz-offset > -24;
            4 - tz-offset;
          hour' =
            assert hour >= -24;
            assert hour <= 47;
            if hour < 0 then
              hour + 24
            else if hour >= 24 then
              hour - 24
            else
              hour;
          value =
            assert hour' >= 0;
            assert hour' < 24;
            "${toString hour'}:40";
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
