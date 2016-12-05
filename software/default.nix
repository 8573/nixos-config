{
  id = "software";
  desc = "user software";
  default = true;
  global = true;
  modules = [
    ./basic
    ./extra
    ./devel
    ./X11
  ];
}
