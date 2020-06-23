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
      "kernel.yama.ptrace_scope" = 1;

      "vm.overcommit_memory" = lib.mkIf
        (config.c74d-params.hardware.memory.main.gigabytes >= 2)
        2;

      # [2018-03-17] Apparently the Nix sandbox requires user namespaces now.
      # I don't know how many it requires, but I assume two for each build job
      # should be enough.
      "user.max_user_namespaces" = config.nix.maxJobs * 2;
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

  boot.kernelPackages = pkgs.linuxPackages_hardened;

  boot.kernelParams = lib.concatLists [
    (lib.optionals config.c74d-params.ZFS.enable [
      # [2020-06-23] Reading gchristensen's blog post
      # <https://grahamc.com/blog/nixos-on-zfs> reminds me that, for the ~5
      # years I've been using NixOS, I've been forgetting to override the
      # Linux I/O scheduler so ZFS can handle I/O scheduling itself without
      # Linux's competing with it.  Back on Gentoo, I would do this while
      # configuring my kernel, but, using pre-built kernels on NixOS, I never
      # thought of it.
      #
      # [2020-06-23] A remark of gchristensen's in IRC after I mention the
      # above ("good news c74d I keep meaning to just delete that line")
      # prompts me to check whether overriding the Linux I/O scheduler has
      # come no longer to be recommended for ZFS users, and indeed I find
      # behlendorf saying that "These days [...] users should not need to
      # change the scheduler":
      # <https://github.com/openzfs/zfs/pull/9609#issuecomment-557325590>.
      #"elevator=none"
    ])
  ];

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
