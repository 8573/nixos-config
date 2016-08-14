{ config, lib, pkgs, ... }: let

  is-loc = x:
    lib.isAttrs x
    && lib.attrNames x == [
      "latitude"
      "longitude"
      "timezone"
    ]
    && lib.isInt x.latitude
    && lib.isInt x.longitude
    && lib.isString x.timezone;

  loc-ty = lib.mkOptionType {
    name = "rough geographical location";
    check = is-loc;
    merge = lib.mergeOneOption;
  };

  loc = timezone: latitude: longitude:
    assert lib.isString timezone;
    assert lib.isInt latitude;
    assert lib.isInt longitude;
    let
      r = {
        inherit timezone latitude longitude;
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
      The location on Earth that features like clocks and Redshift should be
      targeted for. This is only a rough location, because the latitude and
      longitude are represented as integers.
    '';
  };

  config.lib.c74d.places = {
    CA.BC.wd00 = loc "America/Vancouver" (49) (-123);
    US.CA.r001 = loc "America/Los_Angeles" (34) (-118);
    US.CO.p008 = loc "America/Denver" (39) (-105);
    US.NC.p015 = loc "America/New_York" (36) (-80);
  };

}