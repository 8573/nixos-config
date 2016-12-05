{ config, lib, pkgs, ... }: {

  c74d-params = {
    installation-type = "VM";

    personal = lib.mkDefault true;

    # Virtual machines don't use ZFS, so they can run grsecurity.
    secure = lib.mkDefault true;

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
    };
  };

}
