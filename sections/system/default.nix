{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    approx-target-local-time-hm-str
    mk-if-TZ-is-UTC;

in {

  system = {
    # The NixOS release to be compatible with for stateful data such as
    # databases.
    stateVersion = config.c74d-params.system-state-version;

    autoUpgrade = {
      enable = with config.c74d-params;
        usually-up && manages-own-store && usually-on-Internet;
      channel =
        "https://nixos.org/channels/nixos-${config.c74d-params.channel}";
      dates =
        # [2020-06-02] The default time is 04:40, but I move it earlier so
        # that, if this must wake me with its disk churn, it wakes me nearer
        # midnight, when there's less light outside and returning to sleep is
        # easier.
        "Sat ${approx-target-local-time-hm-str 2 0}";
      flags = [
        "-I" "AUTO-BUILD-FLAG=/dev/null/AUTO-BUILD-FLAG"
      ];
    };
  };

}
