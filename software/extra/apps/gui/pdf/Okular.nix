{
  id = "Okular";
  desc = ''
    the heavy-weight document-viewer Okular
  '';
  # [2020-10-09]  Okular's GUI feels sluggish (menus can take a second to
  # open) and it doesn't seem to have implemented as much of the PDF standard
  # as MuPDF has.  I see no need to keep its ~250 MiB around.
  default = {config, parent, ...}:
    { desktop = false;
      laptop = false;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  sw = p: with p; [
    okular
  ];
}
