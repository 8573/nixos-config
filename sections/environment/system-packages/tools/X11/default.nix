{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.mkIf config.services.xserver.enable (with pkgs; [
    xclip
    xorg.xbacklight
    xorg.xev
  ] ++ lib.optionals config.c74d-params.i3.enable [
    dmenu
    i3lock
    i3status
  ]);

}
