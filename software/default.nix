{
  id = "software";
  desc = "user software";
  default = {config, ...}:
    !config.c74d-params.minimal;
  global = true;
  modules = [
    ./basic
    ./extra
    ./devel
    ./X11
    ./VMs
  ];
}
