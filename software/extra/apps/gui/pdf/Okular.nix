{
  id = "Okular";
  desc = ''
    the heavy-weight document-viewer Okular
  '';
  default = {config, parent, ...}:
    { desktop = true;
      laptop = false;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  sw = p: with p; [
    okular
  ];
}
