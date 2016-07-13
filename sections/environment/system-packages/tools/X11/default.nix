{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.optionals config.services.xserver.enable (with pkgs; [
    xclip
  ] ++ lib.optionals config.c74d-params.i3.enable [
    dmenu
    i3status
  ]);

}
