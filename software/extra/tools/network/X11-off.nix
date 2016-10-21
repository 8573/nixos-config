{
  id = "for-non-X11";
  desc = ''
    non-X11 variants of extra user-facing networking-related tools that have
    separate packages for use with and without X11
  '';
  default = {config, ...}:
    !config.services.xserver.enable;
  sw = p: with p; [
    nmap
  ];
}
