# Common applications (that don't require a graphical environment).

{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    elinks
    moc
    vim_configurable
    vlc
    weechat
    xpdf
  ]);

}
