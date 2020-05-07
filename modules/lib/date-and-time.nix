{ config, lib, pkgs, ... }: let

  inherit (config.c74d-params.location)
    normal
    target;

in rec {

  # [2018-06-01] All extant uses of the `approx-target-local-time-*` functions
  # are for creating systemd calendar event specifications (see the
  # systemd.time(7) man-page), and those uses are addressed better by
  # specifying timezones for the calendar events.
  #
  # [2018-06-16] ...Except that specifying timezones for calendar events only
  # seems to work for systemd user units. For system units, the timezone in
  # "[Timer]OnCalendar" seems to be ignored in favor of UTC (the system
  # timezone).
  approx-target-local-time-h = local-hour:
    assert local-hour >= 0;
    assert local-hour < 24;
    let
      tz-offset =
        target.timezone-avg-offset;
      hour =
        assert tz-offset < 24;
        assert tz-offset > -24;
        local-hour - tz-offset;
      hour' =
        assert hour >= -24;
        assert hour <= 47;
        if hour < 0 then
          hour + 24
        else if hour >= 24 then
          hour - 24
        else
          hour;
    in
      assert hour' >= 0;
      assert hour' < 24;
      hour';

  approx-target-local-time-h-str = local-hour:
    let
      h = approx-target-local-time-h local-hour;
      h-str = toString h;
      h-pad = lib.optionalString (h < 10) "0";
      h-str' = "${h-pad}${h-str}";
    in
      assert lib.stringLength h-str' == 2;
      h-str';

  approx-target-local-time-hm-str = local-hour: local-minute:
    assert local-minute >= 0;
    assert local-minute < 60;
    let
      h-str = approx-target-local-time-h-str local-hour;
      m = local-minute;
      m-str = toString m;
      m-pad = lib.optionalString (m < 10) "0";
      hm-str = "${h-str}:${m-pad}${m-str}";
    in
      assert lib.stringLength hm-str == 5;
      hm-str;

  mk-if-TZ-is-UTC = content:
    lib.mkIf
      (assert config.time ? timeZone;
        config.time.timeZone == "UTC")
      content;

}
