{
  id = "FontForge";
  desc = "FontForge";
  default = {config, parent, ...}:
    # FontForge seems surprisingly small, under 20 MiB.
    { desktop = true;
      laptop = true;
      server = false;
      VM = false; }.${config.c74d-params.installation-type}
    && parent.enable;
  sw = p: with p; [
    fontforge-gtk
  ];
}
