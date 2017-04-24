{ config, lib, pkgs, ... }: {

  services.udev.extraRules = lib.concatStrings [
    # ZFS has its own I/O scheduler, with which Linux's I/O schedulers would
    # only interfere, so disable Linux's I/O schedulers for "ata" devices.
    (lib.optionalString config.c74d-params.ZFS.enable ''
      ENV{ID_BUS}=="ata", ATTR{queue/scheduler}="noop"
    '')
  ];

}
