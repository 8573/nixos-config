{ config, lib, pkgs, ... }: {

  options.c74d-params = {

    sleeplock.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to enable a background service named "sleeplock" to encourage
        me to sleep at proper times by locking me out of my desktop
        environment.
      '';
    };

    sleeplock.time.hour = lib.mkOption {
      type = lib.types.int;
      default = 22;
      example = 1;
      description = ''
        The hour of each day at which sleeplock should trigger, if enabled.
      '';
    };

    sleeplock.time.minute = lib.mkOption {
      type = lib.types.int;
      default = 0;
      example = 30;
      description = ''
        The minute of the hour at which sleeplock should trigger, if enabled.
      '';
    };

  };

}
