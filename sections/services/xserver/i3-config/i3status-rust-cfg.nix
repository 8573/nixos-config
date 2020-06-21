{ config, lib, pkgs, ... }: sep-color: let

  cfg = config.c74d-params.i3.status-bar;

  interval = 10;

  interval-squared = interval * interval;

  interval-cubed = interval * interval-squared;

  clock-format = ''"${cfg.clock.format}"'';

  clock = TZ: ''
    [[block]]
    block = "time"
    format = ${clock-format}
    timezone = "${TZ}"
  '';

  uniq-r = list:
    if list == [] then
      []
    else
      let
        xs = lib.init list;
        x = lib.last list;
      in
        lib.remove x (uniq-r xs) ++ [x];

  clock-TZs =
    cfg.clock.extra-timezones
    ++ lib.optional
      cfg.clock.local
      config.c74d-params.location.target.timezone
    ++ lib.optional
      cfg.clock.home
      config.c74d-params.location.normal.timezone
    ++ lib.optional
      cfg.clock.UTC
      "UTC";

  clocks = lib.concatStrings (map clock (uniq-r clock-TZs));

  # The i3status configuration file format supports having advanced Unicode
  # characters directly embedded in UTF-8, but I don't trust such characters
  # to survive our technology intact.
  U-degree = ''\u00B0'';

  block = name: id: contents: lib.optionalString cfg.${name}.enable ''
    [[block]]
    block = "${id}"
    ${lib.concatStrings (
      lib.mapAttrsFlatten
        (k: v: "${k} = ${builtins.toJSON v}\n")
        contents
    )}
  '';

  WiFi-block = device: block "Wi-Fi" "net" {
    inherit interval device;
    ssid = true;
    signal_strength = true;
  };

  Ethernet-block = device: block "Ethernet" "net" {
    inherit interval device;
  };

  WiFi-blocks = lib.concatMapStringsSep "\n" WiFi-block
    config.c74d-params.hardware.Wi-Fi.ifaces;

  Ethernet-blocks = lib.concatMapStringsSep "\n" Ethernet-block
    config.c74d-params.hardware.Ethernet.ifaces;

  battery-block = block "battery" "battery" {
    inherit interval;
    format = "{percentage}% {time} {power}";
  };

  audio-volume-block = block "audio-volume" "sound" {
    natural_mapping = true;
  };

  load-block = block "load" "load" {
    inherit interval;
    format = "{1m} {5m} {15m}";
  };

  temperature-block = block "temperature" "temperature" {
    inherit interval;
    format = "{average}";
    collapsed = false;
  };

  storage-block = block "storage" "disk_space" {
    interval = interval-squared;
  };

  user-block = block "UID" "custom" {
    command = "'${pkgs.coreutils}/bin/id' -u";
    interval = interval-cubed;
  };

in pkgs.writeText "i3status.toml" ''
  ${user-block}
  ${WiFi-blocks}
  ${Ethernet-blocks}
  ${battery-block}
  ${temperature-block}
  ${load-block}
  ${audio-volume-block}
  ${storage-block}
  ${clocks}
  ${user-block}

  [theme]
  name = "plain"

  # The default theme has too little contrast for my taste.
  [theme.overrides]
  idle_fg = "#EEEEEE"
  info_fg = "#FFFFFF"
  good_fg = "#00FF00"
  warning_fg = "#FFBB00"
  critical_fg = "#FF0000"
  separator_bg = "#${sep-color}"
  separator_fg = "#${sep-color}"
''
