{
  id = "devel";
  desc = "developer tools and toolchains";
  default = {config, ...}:
    { desktop = true;
      laptop = true;
      server = false; }
    .${config.c74d-params.installation-type};
  modules = [
    ./languages
    ./version-control
  ];
}
