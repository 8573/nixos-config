{
  id = "extra";
  desc = "extra user-facing software";
  default = {config, parent, ...}:
    { desktop = true;
      laptop = true;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  ignore-broken-pkgs = true;
  modules = [
    ./apps
    ./rare
    ./shells
    ./tools
  ];
}
