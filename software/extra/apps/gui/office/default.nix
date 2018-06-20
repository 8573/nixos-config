{
  id = "office";
  desc = "graphical office software";
  default = {config, parent, ...}:
    { desktop = true;
      laptop = true;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  modules = [
    ./calligra
  ];
}
