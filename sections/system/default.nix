{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    approx-target-local-time-hm-str
    mk-if-TZ-is-UTC;

in {

  system = {
    # The NixOS release to be compatible with for stateful data such as
    # databases.
    stateVersion = "16.03";

    autoUpgrade = {
      enable = with config.c74d-params;
        usually-up && installation-type != "VM";
      channel =
        "https://nixos.org/channels/nixos-${
          { desktop = "unstable";
            laptop = "unstable";
            server = "unstable-small";
            VM = "unstable"; }
          .${config.c74d-params.installation-type}
        }";
      dates =
        mk-if-TZ-is-UTC
          (approx-target-local-time-hm-str 4 40);
      flags = [
        "-I" "AUTO-BUILD-FLAG=/dev/null/AUTO-BUILD-FLAG"
      ];
    };
  };

}
