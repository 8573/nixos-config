{
  id = "Google-Earth";
  desc = "Google Earth";
  default = {config, parent, ...}:
    parent.enable
    && config.c74d-params.personal;
  sw = p: with p; [
    (googleearth.overrideAttrs (_: {
      # Ignore that the package has an "unfree" licence, to install it while
      # still having `allowUnfree = false` apply to most packages. This should
      # not be interpreted as an assertion that Google Earth actually is
      # "Free" software.
      meta.license.free = true;
    }))
  ];
}
