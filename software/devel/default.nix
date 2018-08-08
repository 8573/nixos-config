{
  id = "devel";
  desc = "developer tools and toolchains";
  default = {config, parent, ...}:
    { desktop = true;
      laptop = true;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  ignore-broken-pkgs = true;
  modules = [
    ./debug
    ./languages
    ./project-stats
    ./version-control
  ];
}
