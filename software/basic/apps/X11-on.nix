{
  id = "for-X11";
  desc = "basic application programs that need X11";
  default = {config, parent, ...}:
    config.services.xserver.enable
    && parent.enable;
  sw = p: with p; [
    (rxvt_unicode.override {
      perlSupport = false;
    })
  ];
}
