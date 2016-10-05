{ config, lib, pkgs, ... }: {

  c74d-params = {
    id = "b42d35f1";
    installation-type = "laptop";
    secure = false;
    personal = true;

    location = {
      normal = config.lib.c74d.places.US.CA.r001;
      target = config.lib.c74d.places.US.CA.r001;
    };

    hardware = {
      cores = {
        physical = 4;
        virtual = 8;
      };

      memory = {
        main = {
          gigabytes = 8;
        };
        swap = {
          gigabytes = 16;
        };
      };

      Ethernet = {
        present = false;
      };

      Wi-Fi = {
        present = true;
      };
    };

    X11 = {
      font-size = 13;
    };

    i3 = {
      extraConfig =
        let
          amixer = "${pkgs.alsaUtils}/bin/amixer";
        in ''
          # Key-bindings for audio output control
          bindsym XF86AudioRaiseVolume exec '${amixer}' -Mqc 1 set Master 5%+ unmute
          bindsym XF86AudioLowerVolume exec '${amixer}' -Mqc 1 set Master 5%- unmute
          bindsym XF86AudioMute exec '${amixer}' -Mqc 1 set Master toggle
        '';
    };
  };

  # Prevent Wi-Fi from being significantly slowed when Bluetooth is on.
  boot.extraModprobeConfig = ''
    options iwlwifi bt_coex_active=N
  '';

  boot.loader = {
    timeout = 3;
  };

  fileSystems."/" = {
    device = "zpool-b42d3-0-1/b42d3/nixos";
    fsType = "zfs";
    options = ["noatime" "nodiratime" "suid"];
  };

  fileSystems."/home" = {
    device = "zpool-b42d3-0-1/b42d3/users";
    fsType = "zfs";
    options = ["noatime" "nodiratime" "nosuid"];
  };

  fileSystems."/boot" = {
    device = "UUID=185A-2ABB";
    fsType = "vfat";
    options = ["noatime" "nodiratime" "nodev" "noexec" "nosuid" "utf8" "tz=UTC"];
  };

  fileSystems."/mnt/VoiceTracer-SD-card" = {
    device = "UUID=4406-E439";
    fsType = "vfat";
    options = [
      "noauto" "x-mount.mkdir=755"
      "noatime" "nodiratime" "nodev" "noexec" "nosuid"
      "utf8" "tz=UTC" "ro" "umask=0022"
    ];
  };

  hardware.bluetooth = {
    enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      enablePepperFlash = true;
    };
  };

  powerManagement.enable = false;

  services.redshift = {
    enable = config.c74d-params.X11.enable && false;
  };

  services.xserver = {
    multitouch = {
      # `multitouch` overrides `synaptics` and is less configurable.
      enable = false;
      ignorePalm = true;
    };
    synaptics = {
      enable = true;
      accelFactor = "0.0625";
      /*additionalOptions = ''
        Option "HorizScrollDelta" "256"
        Option "VertScrollDelta" "256"
      '';*/
      maxSpeed = "1.5";
      minSpeed = "0.25";
      palmDetect = true;
      twoFingerScroll = true;
      #vertEdgeScroll = false;
    };
  };

  sound.extraConfig = ''
    defaults.pcm.!card 1
  '';

  swapDevices = [
    { device = "/dev/disk/by-partlabel/Linux-swap-partition-for-b42d3"; }
  ];

}
