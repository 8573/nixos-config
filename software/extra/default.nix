{
  id = "extra";
  desc = "extra user-facing software";
  default = {config, parent, ...}:
    { desktop = true;
      laptop = true;
      server = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  modules = [
    ./apps
    ./rare
    ./shells
    ./tools
  ];
}
