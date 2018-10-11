{
  id = "devel";
  desc = "tools and toolchains for engineering and software development";
  default = {config, parent, ...}:
    { desktop = true;
      laptop = true;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  ignore-broken-pkgs = true;
  modules = [
    ./CAx
    ./debug
    ./languages
    ./project-stats
    ./version-control
  ];
}
