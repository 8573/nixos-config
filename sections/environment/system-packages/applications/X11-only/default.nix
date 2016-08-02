{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.mkIf config.services.xserver.enable (with pkgs; [
    chromium
    audacity
    nmap_graphical
    gimp
  ]);

}
