# Common applications (that don't require a graphical environment).

{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    elinks
    moc
    vlc
    weechat
    xpdf
  ]);

}
