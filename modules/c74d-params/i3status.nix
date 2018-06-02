{ config, lib, pkgs, ... }: let

  hw = config.c74d-params.hardware;

  mk-bool-opt = default: description: lib.mkOption {
    type = lib.types.bool;
    inherit default description;
  };

  mk-modl-enbl-opt = default: description:
    mk-bool-opt default ''
      Whether the status bar should include information about ${description}.
    '';

in {

  options.c74d-params.i3.status-bar = {

    refresh-interval = lib.mkOption {
      type = lib.types.int;
      default = 5;
      example = 1;
      description = ''
        The time, in seconds, that the status bar is to wait between
        refreshes.
      '';
    };

    storage.enable = mk-modl-enbl-opt false ''
      the storage device holding the root filesystem
    '';

    IPv6.enable = mk-modl-enbl-opt config.networking.enableIPv6 ''
      the system's IPv6 Internet connection
    '';

    Wi-Fi.enable = mk-modl-enbl-opt hw.Wi-Fi.present ''
      the system's Wi-Fi connection
    '';

    Ethernet.enable = mk-modl-enbl-opt hw.Ethernet.present ''
      the system's Ethernet connection
    '';

    battery.enable = mk-modl-enbl-opt hw.battery.present ''
      battery power
    '';

    audio-volume.enable = mk-modl-enbl-opt (
      with config; sound.enable || hardware.pulseaudio.enable
    ) ''
      audio volume
    '';

    load.enable = mk-modl-enbl-opt true ''
      the system load
    '';

    temperature.enable = mk-modl-enbl-opt true ''
      CPU temperature
    '';

    Unicode-symbols.advanced.enable = mk-bool-opt true ''
      Whether to use advanced Unicode symbols such as U+1F50B BATTERY in the
      status bar.
    '';

    clock.UTC = mk-bool-opt true ''
      Whether the status bar should include a clock displaying Universal
      Coordinated Time.
    '';

    clock.home = mk-bool-opt true ''
      Whether the status bar should include a clock displaying time in the
      time-zone of what is configured as the system's normal location.
    '';

    clock.local = mk-bool-opt true ''
      Whether the status bar should include a clock displaying time in the
      time-zone of what is configured as the system's current location.
    '';

    clock.extra-timezones = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["America/Los_Angeles" "Europe/Berlin"];
      description = ''
        Additional time-zones for which to include clocks in the status bar.
      '';
    };

    clock.format = lib.mkOption {
      type = lib.types.str;
      default = "%a %F %T %Z";
      example = "%a %x %X %Z";
      description = ''
        A `strftime` format string to use as the output format for the status
        bar's clock(s).
      '';
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Extra text to append to the i3status configuration file.
      '';
    };

  };

}
