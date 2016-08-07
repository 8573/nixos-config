{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.mkIf config.services.xserver.enable (with pkgs; [
    audacity
    chromium
    gimp
    nmap_graphical
  ]);

}
