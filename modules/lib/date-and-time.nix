{ config, lib, pkgs, ... }: let

  inherit (config.c74d-params.location)
    normal
    target;

in rec {

  # [2018-06-01] All extant uses of the `approx-target-local-time-*` functions
  # were for creating systemd calendar event specifications (see the
  # systemd.time(7) man-page), and those uses are addressed better by
  # specifying timezones for the calendar events.
  /*
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
      h = toString (approx-target-local-time-h local-hour);
      h-pad = lib.optionalString (local-hour < 10) "0";
    in
      "${h-pad}${h}";

  approx-target-local-time-hm-str = local-hour: local-minute:
    assert local-minute >= 0;
    assert local-minute < 60;
    let
      h-str = approx-target-local-time-h-str local-hour;
      m = toString local-minute;
      m-pad = lib.optionalString (local-minute < 10) "0";
    in
      "${h-str}:${m-pad}${m}";
  */

  mk-if-TZ-is-UTC = content:
    lib.mkIf
      (assert config.time ? timeZone;
        config.time.timeZone == "UTC")
      content;

}
