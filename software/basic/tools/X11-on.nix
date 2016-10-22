{
  id = "for-X11";
  desc = "basic tools that need X11";
  default = {config, parent, ...}:
    config.services.xserver.enable
    && parent.enable;
  sw = p: with p; [
    c74d.vim-try-x
  ];
}
