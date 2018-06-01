{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    mk-if-TZ-is-UTC;

in {

  system = {
    autoUpgrade = {
      enable = with config.c74d-params;
        usually-up && manages-own-store && usually-on-Internet;
      channel =
        "https://nixos.org/channels/nixos-${config.c74d-params.channel}";
      dates =
        mk-if-TZ-is-UTC
          "04:40 ${config.c74d-params.location.target.timezone}";
      flags = [
        "-I" "AUTO-BUILD-FLAG=/dev/null/AUTO-BUILD-FLAG"
      ];
    };

    nixos = {
      # The NixOS release to be compatible with for stateful data such as
      # databases.
      stateVersion = config.c74d-params.system-state-version;
    };
  };

}
