# sleeplock: A systemd user service to encourage me to sleep at proper times
# by locking my desktop environment. (While the name "sleeplock" could
# reasonably be derived from that sentence, it is more based on the name of
# eddyb's "worklock".)

{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    approx-target-local-time-hm-str;

  inherit (config.lib.c74d.pkgs.wrapped)
    i3lock;

  cfg = config.c74d-params.sleeplock;

  i3lock-cmd = "${i3lock}/bin/i3lock --nofork";

in {

  systemd.user.services.c74d-sleeplock = {
    description = "c74d's sleep encouragement";

    restartIfChanged = false;

    script = ''
      function is-running {
        '${pkgs.procps}/bin/ps' -d --format comm --no-headers |
          grep --fixed-strings --line-regexp --quiet "$1"
      }

      if ! is-running i3; then
        echo 'i3 is not running'
        exit 0
      fi

      if is-running i3lock; then
        echo 'i3lock is already running'
        exit 0
      fi

      echo 'Running `${i3lock-cmd}`'
      ${i3lock-cmd}
    '';

    serviceConfig = {
      Type = "oneshot";
    };

    startAt =
      lib.optional
        cfg.enable
        (approx-target-local-time-hm-str cfg.time.hour cfg.time.minute);

    unitConfig = {
      X-StopOnRemoval = false;
    };
  };

}
