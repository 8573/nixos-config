{ config, lib, pkgs, ... }: {

  c74d-params = {
    id = "dec4a944";
    installation-type = "desktop";
    secure = false;
    personal = true;
    system-state-version = "17.03";

    location = {
      normal = config.lib.c74d.places.US.CA.r001;
      target = config.lib.c74d.places.US.CA.r001;
    };

    firmware = {
      type = "EFI";
    };

    hardware = {
      main-CPU-mfr = "Intel";

      cores = {
        physical = 8;
        virtual = 16;
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
        present = true;
      };

      Wi-Fi = {
        present = true;
      };
    };

    #KDE.enable = true;

    sleeplock = {
      enable = true;
    };
  };

  fileSystems."/" = {
    device = "zpool-dec4a-0-1/root/nixos";
    fsType = "zfs";
    options = ["noatime" "nodiratime" "suid"];
  };

  fileSystems."/home" = {
    device = "zpool-dec4a-0-1/users";
    fsType = "zfs";
    options = ["noatime" "nodiratime" "nosuid"];
  };

  fileSystems."/boot" = {
    device = "UUID=9786-99E0";
    fsType = "vfat";
    options = ["noatime" "nodiratime" "nodev" "noexec" "nosuid" "utf8" "tz=UTC"];
  };

  services.redshift = {
    enable = config.c74d-params.X11.enable && false;
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/7c57cf03-d918-410b-bb9e-b0f56476f078"; }
  ];

}
