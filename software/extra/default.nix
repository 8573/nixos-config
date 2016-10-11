{
  id = "extra";
  name = "extra user-facing software";
  default = {config, ...}:
    { desktop = true;
      laptop = true;
      server = false; }
    .${config.c74d-params.installation-type};
  modules = [
    ./shells
    ./tools
  ];
}
