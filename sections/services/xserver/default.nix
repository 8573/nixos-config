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
      gdm = {
        enable = config.services.xserver.enable;

        # For ZFS's sake
        autoSuspend = false;
      };
      lightdm = {
        # [2020-06-19] Today, wondering whether the 2018 issue ticket implying
        # that all of NixOS's display managers are configured to run X as root
        # might have become outdated, I tried switching from LightDM, which
        # does run X as root, to GDM, which, to my pleasant surprise, seems
        # not to.
        enable = false && config.services.xserver.enable;

        # Use a blank black desktop background rather than an image of a
        # gradient and a NixOS logo.
        #
        # [2020-06-17] See <https://github.com/NixOS/nixpkgs/issues/90558>.
        #background = "#000000";
        greeters.gtk.extraConfig = ''
          background = #000000
        '';
      };

      # [2020-09-01] If someday I decide to use a desktop background image,
      # this, today's featured picture on English Wikipedia, respectable,
      # public-domain, and not too bright in color, may work:
      # <https://upload.wikimedia.org/wikipedia/commons/5/5c/Albert_Bierstadt_-_Among_the_Sierra_Nevada,_California_-_Google_Art_Project.jpg>.
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

  # [2020-06-19] Disable AccountsService to disable GDM's user list, since no
  # other available means of enforcing my `hiddenUsers` setting seems to work.
  services.accounts-daemon.enable =
    (if config.services.xserver.displayManager.gdm.enable
      then lib.mkForce
      else lib.mkDefault)
    false;

  # [2020-06-19] Enforce the `hiddenUsers` setting on GDM.
  #
  # [2020-06-19] This doesn't seem to have any effect, so I'm disabling the
  # AccountsService entirely instead.
  environment.etc."gdm/custom.conf".text = lib.mkIf
    (false && config.services.xserver.displayManager.gdm.enable)
    (let
      # [2020-06-19] According to GDM's manual, this default value of
      # `[greeter]Exclude` must be copied because setting `[greeter]Exclude`
      # overrides it.  I imagine there is a better way of copying it that
      # would stay in sync with GDM if GDM changes the default value.
      defaultExclude = "bin,root,daemon,adm,lp,sync,shutdown,halt,mail,news,uucp,operator,nobody,nobody4,noaccess,postgres,pvm,rpm,nfsnobody,pcap";
    in ''
      [greeter]
      IncludeAll=false
      Exclude=${defaultExclude},${lib.concatStringsSep ","
          config.services.xserver.displayManager.hiddenUsers}
    '');

  systemd.services.c74d-set-X11-VTs-to-RAW-mode = lib.mkIf
    config.services.xserver.displayManager.lightdm.enable
  {
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
