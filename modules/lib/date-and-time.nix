{ config, lib, pkgs, ... }: let

  inherit (config.c74d-params.location)
    normal
    target;

in rec {

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

}
