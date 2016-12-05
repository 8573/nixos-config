{
  id = "software";
  desc = "user software";
  default = {config, ...}:
    !config.c74d-params.lightweight;
  global = true;
  modules = [
    ./basic
    ./extra
    ./devel
    ./X11
  ];
}
