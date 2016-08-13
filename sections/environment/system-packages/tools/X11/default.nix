{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.mkIf config.services.xserver.enable (with pkgs; [
    xclip
    xorg.xbacklight
    xorg.xev
  ]);

}
