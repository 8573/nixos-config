{
  id = "rare";
  desc = ''
    packages that I expect to be rarely used and not generally worth the
    storage space in which to keep them around
  '';
  default = false;
  global = false;
  modules = [
    ./graphics
  ];
}
