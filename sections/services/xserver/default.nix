{ config, lib, pkgs, ... }: {

  imports = [
    ./xresources
  ];

  services.xserver = {
    enable = config.c74d-params.X11.enable;

    desktopManager = {
      default = lib.mkIf config.c74d-params.KDE.enable "kde5";
      kde5.enable = config.c74d-params.KDE.install;
      xterm.enable = false;
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
      default = lib.mkIf config.c74d-params.i3.enable "i3";
      i3.enable = config.c74d-params.i3.install;
    };

    xkbOptions = "compose:caps";
  };

}
