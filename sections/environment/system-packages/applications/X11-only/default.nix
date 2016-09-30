{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.mkIf config.services.xserver.enable ((with pkgs; [
    audacity
    chromium
    gimp
    inkscape
    nmap_graphical
    (rxvt_unicode.override {
      perlSupport = false;
    })
  ]) ++ (with config.lib.c74d.pkgs; [
    c74d.vim-try-x
  ]));

}
