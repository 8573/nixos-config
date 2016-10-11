{
  id = "tools";
  name = "extra user-facing tools";
  sw = p: with p; [
    agrep
    alsaUtils
    aspell
    drive
    imagemagick
    libav
    libqalculate
    pdfdiff
  ];
}
