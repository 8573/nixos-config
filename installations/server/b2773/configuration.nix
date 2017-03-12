{ config, lib, pkgs, ... }: {

  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
  ];

  c74d-params = {
    id = "b2773710";
    installation-type = "server";
    secure = false;
    personal = true;
    system-state-version = "17.03";

    location = {
      normal = config.lib.c74d.places.US.NY.c002;
      target = config.lib.c74d.places.US.NY.c002;
    };

    firmware = {
      type = "BIOS";
    };

    hardware = {
      main-CPU-mfr = "(virtual)";

      cores = {
        physical = 0;
        virtual = 2;
      };

      memory = {
        main = {
          gigabytes = 1;
        };
        swap = {
          gigabytes = 1;
        };
      };

      Ethernet = {
        present = true;
      };

      Wi-Fi = {
        present = false;
      };
    };
  };

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "sr_mod"
    "uhci_hcd"
    "virtio_blk"
    "virtio_pci"
  ];

  boot.loader.grub.device = "/dev/vda";

  fileSystems."/" = {
    device = "zpool-b2773-0-1/root";
    fsType = "zfs";
    options = ["noatime" "nodiratime" "nosuid"];
  };

  fileSystems."/data" = {
    device = "zpool-b2773-0-1/data";
    fsType = "zfs";
    options = ["noatime" "nodiratime" "nodev" "noexec" "nosuid"];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/86cd1034-2e7d-4cd7-a4d1-e68970c8a8a8"; }
  ];

}
