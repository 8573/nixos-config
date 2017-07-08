{ config, lib, pkgs, ... }: let

  is-loc = x:
    lib.isAttrs x
    && lib.attrNames x == [
      "latitude"
      "longitude"
      "timezone"
      "timezone-avg-offset"
    ]
    && lib.isInt x.latitude
    && lib.isInt x.longitude
    && lib.isString x.timezone
    && lib.isInt x.timezone-avg-offset;

  loc-ty = lib.mkOptionType {
    name = "rough geographical location";
    check = is-loc;
    merge = lib.mergeOneOption;
  };

  loc = timezone: timezone-avg-offset: latitude: longitude:
    assert lib.isString timezone;
    assert lib.isInt latitude;
    assert lib.isInt longitude;
    let
      r = {
        inherit timezone timezone-avg-offset latitude longitude;
      };
    in
      assert is-loc r;
      r;

in {

  options.c74d-params.location.normal = lib.mkOption {
    type = loc-ty;
    example = config.lib.c74d.places.US.CA.r001;
    description = ''
      The location on Earth where this computer normally is to be found. This
      is only a rough location, because the latitude and longitude are
      represented as integers.
    '';
  };

  options.c74d-params.location.target = lib.mkOption {
    type = loc-ty;
    example = config.lib.c74d.places.US.CO.p008;
    description = ''
      The location on Earth for which features like clocks and Redshift should
      be targeted. This is only a rough location, because the latitude and
      longitude are represented as integers.
    '';
  };

  config.lib.c74d.places = {
    nowhere = loc "UTC" (0) (0) (0);
    CA.BC.wd00 = loc "America/Vancouver" (-8) (49) (-123);
    US.CA.r001 = loc "America/Los_Angeles" (-8) (34) (-118);
    US.CO.p008 = loc "America/Denver" (-7) (39) (-105);
    US.NC.p015 = loc "America/New_York" (-5) (36) (-80);
    US.NY.c002 = loc "America/New_York" (-5) (43) (-79);
  };

}
