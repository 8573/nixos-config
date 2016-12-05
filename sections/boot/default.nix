{ config, lib, pkgs, ... }: let

  mk-if-non-minimal =
    lib.mkIf (!config.c74d-params.minimal);

in {

  boot.cleanTmpDir = true;

  boot.initrd = {
    availableKernelModules = mk-if-non-minimal
      ["ehci_pci" "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
    kernelModules = mk-if-non-minimal [
      "zfs"
    ];
    supportedFilesystems = mk-if-non-minimal [
      "vfat"
      "zfs"
    ];
  };

  boot.kernel = {
    sysctl = {
      "vm.overcommit_memory" = lib.mkIf
        (config.c74d-params.hardware.memory.main.gigabytes >= 2)
        2;
    };
  };

  boot.kernelModules = mk-if-non-minimal
    (lib.concatLists [
      (lib.optional
        (config.c74d-params.hardware.main-CPU-mfr == "Intel")
        "kvm-intel")
      (lib.optional
        (config.c74d-params.hardware.main-CPU-mfr == "AMD")
        "kvm-amd")
    ]);

  boot.loader = {
    systemd-boot = {
      enable = !config.c74d-params.minimal;
    };
    efi = {
      canTouchEfiVariables = config.boot.loader.systemd-boot.enable;
    };
  };

  # Per <https://nixos.org/wiki/ZFS_on_NixOS>.
  boot.supportedFilesystems = mk-if-non-minimal [
    "vfat"
    "zfs"
  ];

  boot.tmpOnTmpfs = true;

  boot.zfs = mk-if-non-minimal {
    forceImportAll = false;
    forceImportRoot = false;
  };

}
