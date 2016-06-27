{ config, lib, pkgs, ... }: {

  c74d-params = {
    id = "dec4a944";
    installation-type = "desktop";
    secure = false;

    hw.cores = 8;

    KDE.enable = true;
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
    device = "/dev/disk/by-uuid/9786-99E0";
    fsType = "vfat";
    options = ["noatime" "nodiratime" "nosuid" "utf8" "tz=UTC"];
  };

  services.redshift = {
    enable = !config.environment.noXlibs && false;
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/7c57cf03-d918-410b-bb9e-b0f56476f078"; }
  ];

  system.autoUpgrade = {
    enable = true;
  } // lib.optionalAttrs (
    assert config.time ? timeZone;
      config.time.timeZone == "UTC"
  ) {
    dates = "11:40";
  };

}
