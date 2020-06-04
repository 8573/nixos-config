{
  id = "viewer";
  desc = ''
    one or more graphical applications (other than Chromium) for viewing
    Portable Document Format (PDF) documents
  '';
  default = {config, parent, ...}:
    { desktop = true;
      laptop = false;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  sw = p: with p; [
    mupdf
  ];
}
