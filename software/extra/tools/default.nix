{
  id = "tools";
  name = "extra user-facing tools";
  # TODO: Make this default to the parent module's default.
  default = true;
  sw = (p: with p; [
    agrep
    alsaUtils
    aspell
    drive
    (lib.getBin imagemagick)
    (lib.getBin libav)
    (lib.getBin libqalculate)
    pdfdiff
  ]);
}
