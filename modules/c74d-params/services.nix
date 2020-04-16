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

    sleeplock.times = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          hour = lib.mkOption {
            type = lib.types.ints.between 0 23;
            default = 22;
            example = 1;
            description = ''
              The hour of each day at which sleeplock should trigger, if
              enabled
            '';
          };
          minute = lib.mkOption {
            type = lib.types.ints.between 0 59;
            default = 0;
            example = 30;
            description = ''
              The minute of the hour at which sleeplock should trigger, if
              enabled
            '';
          };
        };
      });
      default = [{}];
      example = [{hour = 20;} {hour = 1; minute = 30;}];
      description = ''
        The times each day at which sleeplock should trigger, if enabled
      '';
    };

  };

}
