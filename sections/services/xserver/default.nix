{ config, lib, pkgs, ... }: {

  imports = [
    ./xresources
    ./i3-config
  ];

  services.xserver = {
    enable = config.c74d-params.X11.enable;

    desktopManager = {
      #plasma5.enable = config.c74d-params.KDE.install;
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = lib.mkIf config.c74d-params.i3.enable "none+i3";
      hiddenUsers = [
        "nobody"
      ];
      lightdm = {
        enable = config.services.xserver.enable;

        # Use a blank black desktop background rather than an image of a
        # gradient and a NixOS logo.
        #
        # [2020-06-17] See <https://github.com/NixOS/nixpkgs/issues/90558>.
        #background = "#000000";
        greeters.gtk.extraConfig = ''
          background = #000000
        '';
      };
    };

    libinput = lib.mkIf (lib.elem config.c74d-params.installation-type [
      # I expect laptop computers to have integral touchpads.
      "laptop"
      # I might connect a peripheral touchpad to a desktop computer.
      "desktop"
    ]) {
      enable = true;
    };

    windowManager = {
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
