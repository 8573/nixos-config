{ config, lib, pkgs, ... }: {

  services.xserver.displayManager.sessionCommands =
    lib.mkIf config.services.xserver.enable ''
      if [ -f '/etc/X11/Xresources' ]; then
        '${pkgs.xorg.xrdb}/bin/xrdb' -merge '/etc/X11/Xresources'
      fi
    '';

}
