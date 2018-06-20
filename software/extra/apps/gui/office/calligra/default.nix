{
  # Calligra doesn't seem to work outside KDE; for me in just i3, its
  # component programs crash when I try to start them, complaining of missing
  # some kind of media type registry, and then what appears to be a socket to
  # which to report their crashes.
  id = "calligra";
  desc = "Calligra";
  default = {config, parent, ...}:
    config.c74d-params.KDE.enable
    && parent.enable;
  sw = p: with p; [
    kde4.calligra
  ];
}
