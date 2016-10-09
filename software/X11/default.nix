{
  id = "X11";
  name = "X11-dependent software";
  default = {config, ...}:
    config.c74d-params.X11.enable;
  modules = [
    ./tools
  ];
}
