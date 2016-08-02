{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.optionals config.services.xserver.enable (with pkgs; [
    chromium
    audacity
    nmap_graphical
    gimp
  ]);

}
