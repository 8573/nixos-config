{
  id = "tools";
  name = "extra user-facing tools";
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
