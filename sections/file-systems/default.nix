{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    mk-if-non-minimal;

in {

  fileSystems."/mnt" = mk-if-non-minimal {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "noatime" "nodiratime" "nodev" "noexec" "nosuid"
      "size=1m"
    ];
  };

}
