{
  id = "software";

  desc = "user software";

  # `default` is *not* inherited by sub-modules. However, the state of being
  # enabled in the installation configuration *is* inherited by sub-modules.
  default = {config, ...}:
    !config.c74d-params.minimal;

  # `global` is inherited by sub-modules.
  global = true;

  # `ignore-broken-pkgs` is inherited by sub-modules.
  ignore-broken-pkgs = false;

  # `filter-outputs` is *not* inherited by sub-modules; it defaults to `true`.
  filter-outputs = true;

  modules = [
    ./basic
    ./extra
    ./devel
    ./X11
    ./VMs
    ./tests
  ];
}
