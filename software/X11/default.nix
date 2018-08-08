{
  id = "X11";
  desc = "X11-dependent software";
  default = {config, ...}:
    config.c74d-params.X11.enable;
  modules = [
    ./data
    ./tools
  ];
}
