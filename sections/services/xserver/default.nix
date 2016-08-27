{ config, lib, pkgs, ... }: {

  imports = [
    ./xresources
    ./i3-config
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

  systemd.services.c74d-set-X11-VTs-to-RAW-mode = {
    after = ["display-manager.service"];
    partOf = ["display-manager.service"];
    wantedBy = ["display-manager.service"];
    serviceConfig.Type = "oneshot";
    script = ''
      sleep 5
      for n in $(
        '${pkgs.procps}/bin/pgrep' --full --list-full \
          '/bin/X .*\<vt[0-9]+\>' \
        | sed 's/.*\<vt\([0-9]\+\)\>.*/\1/'
      ); do
        tty="/dev/tty$n"
        if [ -w "$tty" ]; then
          echo "Setting RAW mode on $tty"
          '${pkgs.kbd}/bin/kbd_mode' -s -C "$tty"
        fi
      done
    '';
  };

}
