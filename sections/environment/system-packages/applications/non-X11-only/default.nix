# Non-X11 variants of programs with separate packages for no-X and (yes-X +
# no-X), or other programs that shouldn't be installed if X is enabled.

{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.mkIf (!config.services.xserver.enable) (with pkgs; [
    nmap
  ]);

}
