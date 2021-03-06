{
  id = "viewer";
  desc = ''
    one or more graphical applications (other than Chromium) for viewing
    Portable Document Format (PDF) documents
  '';
  default = {config, parent, ...}:
    { desktop = true;
      laptop = true;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  modules = [
    ./MuPDF.nix
    ./Okular.nix
  ];
}
