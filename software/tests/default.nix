{
  id = "tests";
  desc = ''
    otherwise-useless packages intended to test aspects of this
    software-module system
  '';
  default = true;
  modules = [
    ./ignore-broken-pkgs
  ];
}
