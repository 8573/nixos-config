{ config, lib, pkgs, ... }: {

  fileSystems."/mnt" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "noatime" "nodiratime" "nodev" "noexec" "nosuid"
      "size=1m"
    ];
  };

}
