{ config, lib, pkgs, ... }: {

  c74d-params = {
    installation-type = "VM";

    personal = lib.mkDefault true;

    # Virtual machines don't use ZFS, so they can run grsecurity.
    secure = lib.mkDefault true;

    location = {
      normal = lib.mkDefault config.lib.c74d.places.nowhere;
      target = lib.mkDefault config.lib.c74d.places.nowhere;
    };

    hardware = {
      main-CPU-mfr = "(virtual)";

      memory = {
        main = {
          gigabytes =
            lib.mkDefault (config.virtualisation.memorySize / 1024);
        };
        swap = {
          gigabytes = lib.mkDefault 0;
        };
      };

      Ethernet = {
        present = lib.mkDefault false;
      };

      Wi-Fi = {
        present = lib.mkDefault false;
      };

      battery = {
        present = lib.mkDefault false;
      };
    };
  };

  # `boot.tmpOnTmpfs = true` causes a tmpfs to be mounted *over* the 9P
  # mount-points in `/tmp` that one is to use to exchange data with the host,
  # rendering them inaccessible.
  # [<https://github.com/NixOS/nixpkgs/issues/21490>]
  boot.tmpOnTmpfs = lib.mkForce false;

  services.fail2ban.enable = false;

  users.users = {
    root = {
      hashedPassword = lib.mkOverride 60 "$6$KMwVgk/Oz8wdeX48$PS..8q81o2IYvDlzQ4WddRAKCwHE7QYMKzXhup7Bz3QHji.scHd3drBFWPXafCZOwMgMLA8.HwNZhiwGwNqgr/";
    };

    user = {
      isNormalUser = true;
      hashedPassword = lib.mkOverride 60 "$6$rprMXsMczzrJOT$/mgR1LkI.aPglsyDXfBssX95J3.RExv/sHAsgX8Ij3WCODzMKhVlcZVoYAvhNKwr7cvzHq0dizV6RYt933c0F/";
    };
  };

}
