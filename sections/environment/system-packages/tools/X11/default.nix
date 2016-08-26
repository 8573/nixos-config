{ config, lib, pkgs, ... }: let

  c74d-pkgs = config.lib.c74d.pkgs;

in {

  environment.systemPackages = lib.mkIf config.services.xserver.enable (with pkgs; [
    xclip
    xorg.xbacklight
    xorg.xev
  ] ++ lib.optionals config.c74d-params.i3.enable [
    c74d-pkgs.wrapped.i3lock
  ]);

}
