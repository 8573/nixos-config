{ config, lib, pkgs, ... }: {

  services.xserver = {
    enable = config.c74d-params.X11.enable;

    desktopManager = {
      kde5.enable = config.c74d-params.KDE.install;
      xterm.enable = false;
    } // lib.optionalAttrs config.c74d-params.KDE.enable {
      default = "kde5";
    };

    displayManager = {
      hiddenUsers = [
        "nobody"
      ];
    } // (if config.c74d-params.KDE.enable then {
      sddm = {
        enable = config.services.xserver.enable;
      };
    } else {
      lightdm = {
        enable = config.services.xserver.enable;
        background = "#000000";
      };
    });

    windowManager = {
      i3.enable = config.c74d-params.i3.install;
    } // lib.optionalAttrs config.c74d-params.i3.enable {
      default = "i3";
    };

    xkbOptions = "compose:caps";
  };

}
