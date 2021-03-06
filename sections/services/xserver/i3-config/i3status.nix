{ config, lib, pkgs, ... }: let

  cfg = config.c74d-params.i3.status-bar;

  clock-format = ''" ${cfg.clock.format} "'';

  clock = TZ: ''
    order += "tztime ${TZ}"
    tztime ${TZ} {
            format = ${clock-format}
            timezone = "${TZ}"
    }
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
  U-thin-sp = ''\xE2\x80\x89'';
  U-antenna-with-bars = ''\xF0\x9F\x93\xB6'';
  U-battery = ''\xF0\x9F\x94\x8B'';
  U-electric-plug = ''\xF0\x9F\x94\x8C'';
  U-degree = ''\xC2\xB0'';
  U-sound = ''\xF0\x9F\x8E\xB5'';

  Unicode-icon = description: symbol:
    if cfg.Unicode-symbols.advanced.enable then
      "${U-thin-sp}${symbol}${U-thin-sp}"
    else
      " ${description} ";

  WiFi-icon = Unicode-icon "Wi-Fi" U-antenna-with-bars;
  Ethernet-icon = " Ethernet ";
  battery-icon = Unicode-icon "BAT" U-battery;
  charging-icon = Unicode-icon "CHR" U-electric-plug;
  audio-volume-icon = Unicode-icon "VOL" U-sound;

  block = name: id: contents: lib.optionalString cfg.${name}.enable ''
    order += "${id}"
    ${id} {
    ${lib.concatStrings (
      lib.mapAttrsFlatten
        (k: v: "        ${k} = \"${v}\"\n")
        contents
    )}}
  '';

  IPv6-block = block "IPv6" "ipv6" {
    format_up = " %ip ";
    format_down = " IPv6 offline ";
  };

  WiFi-block = block "Wi-Fi" "wireless _first_" {
    format_up = "${WiFi-icon}%quality %bitrate %essid %ip ";
    format_down = "${WiFi-icon}offline ";
  };

  Ethernet-block = block "Ethernet" "ethernet _first_" {
    format_up = "${Ethernet-icon} %ip";
    format_down = "${Ethernet-icon}offline ";
  };

  battery-block = block "battery" "battery 0" {
    format = "%status%percentage %remaining %consumption ";
    status_bat = battery-icon;
    status_chr = charging-icon;
    status_full = "${battery-icon}FULL${charging-icon}";
    low_threshold = "30";
    threshold_type = "time";
  };

  audio-volume-block = block "audio-volume" "volume master" {
    format = "${audio-volume-icon}%volume ";
    format_muted = "${audio-volume-icon}off ";
    mixer = "Master";
    mixer_idx = "0";
  };

  load-block = block "load" "load" {
    format = " %1min %5min %15min ";
  };

  temperature-block = block "temperature" "cpu_temperature 0" {
    format = " %degrees ${U-degree}C ";
  };

  storage-block = lib.optionalString cfg.storage.enable ''
    order += "disk /"
    disk "/" {
            format = " %avail ";
    }
  '';

in pkgs.writeText "i3status.conf" ''
  general {
          colors = true
          interval = ${toString cfg.refresh-interval}
  }

  ${IPv6-block}
  ${WiFi-block}
  ${Ethernet-block}
  ${battery-block}
  ${temperature-block}
  ${load-block}
  ${audio-volume-block}
  ${storage-block}
  ${clocks}

  ${cfg.extraConfig}
''
