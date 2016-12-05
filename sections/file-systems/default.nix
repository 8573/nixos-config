{ config, lib, pkgs, ... }: {

  fileSystems."/mnt" = lib.mkIf (!config.c74d-params.minimal) {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "noatime" "nodiratime" "nodev" "noexec" "nosuid"
      "size=1m"
    ];
  };

}
