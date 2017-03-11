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
        usually-up && installation-type != "VM";
      channel =
        "https://nixos.org/channels/nixos-${config.c74d-params.channel}";
      dates =
        mk-if-TZ-is-UTC
          (approx-target-local-time-hm-str 4 40);
      flags = [
        "-I" "AUTO-BUILD-FLAG=/dev/null/AUTO-BUILD-FLAG"
      ];
    };
  };

}
