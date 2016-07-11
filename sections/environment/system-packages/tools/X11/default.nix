{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.optionals config.services.xserver.enable (with pkgs; [
    dmenu
    i3status
    xclip
  ]);

}
