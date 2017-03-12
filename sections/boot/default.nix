{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    mk-if-non-minimal;

in {

  boot.cleanTmpDir = true;

  boot.initrd = {
    availableKernelModules = mk-if-non-minimal
      ["ehci_pci" "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
    kernelModules = lib.mkIf config.c74d-params.ZFS.enable [
      "zfs"
    ];
    inherit (config.boot) supportedFilesystems;
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

  boot.kernelPackages = pkgs.linuxPackages_4_4;

  boot.loader = {
    efi = {
      canTouchEfiVariables = config.boot.loader.systemd-boot.enable;
    };
    grub = {
      enable = config.c74d-params.firmware.type == "BIOS";
      zfsSupport = config.c74d-params.ZFS.enable;
    };
    systemd-boot = {
      enable = config.c74d-params.firmware.type == "EFI";
    };
  };

  # Per <https://nixos.org/wiki/ZFS_on_NixOS>.
  boot.supportedFilesystems =
    lib.optional (!config.c74d-params.minimal) "vfat"
    ++ lib.optional config.c74d-params.ZFS.enable "zfs";

  boot.tmpOnTmpfs = true;

  boot.zfs = {
    forceImportAll = false;
    forceImportRoot = false;
  };

}
