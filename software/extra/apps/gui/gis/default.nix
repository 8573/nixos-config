{
  id = "gis";
  desc = "graphical geographic information system (GIS) software";
  default = {config, parent, ...}:
    { desktop = true;
      laptop = false;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable
    && config.c74d-params.personal;
  modules = [
    ./Google-Earth
  ];
}
