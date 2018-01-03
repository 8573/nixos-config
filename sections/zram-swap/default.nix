{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    mk-if-non-minimal;

  mkswap = "${pkgs.utillinux}/sbin/mkswap";
  nproc = "${pkgs.coreutils}/bin/nproc";
  sed = "${pkgs.gnused}/bin/sed";
  sh = "${pkgs.bash}/bin/sh";
  swapon = "${pkgs.utillinux}/sbin/swapon";

in {

  zramSwap = {
    enable = false;
  };

  boot.kernelModules = mk-if-non-minimal ["zram"];

  # [2017-01-03] Derived from eternaleye's configuration.
  #
  # [2017-01-03] eternaleye's comment on the merits of setting zRAM capacity
  # to the full RAM capacity, as he does, was "*shrug*", yet I trust him
  # enough to do likewise despite some misgivings about edge cases. (What if
  # zRAM fills the RAM and needs to swap? Might it try to swap into itself?)
  #
  # [2017-01-03] eternaleye's comment on the merits of running `swapon` here
  # rather than putting the swap device in `fstab` (as NixOS's `swapDevices`
  # configuration option would) was that the ordering between udev and `fstab`
  # is insufficiently guaranteed.
  services.udev.extraRules = mk-if-non-minimal ''
    SUBSYSTEM=="block", KERNEL=="zram*", ACTION=="add", IMPORT{program}="${sh} -c 'echo NCPUS=$(${nproc})'", ATTR{comp_algorithm}="lz4", ATTR{max_comp_streams}="$env{NCPUS}"
    SUBSYSTEM=="block", KERNEL=="zram0", ACTION=="add", IMPORT{program}="${sed} -n -e '/^MemTotal:/!d; s/^MemTotal:\s*/ZRAMSIZE=/; s/ kB/K/p' /proc/meminfo", ATTR{disksize}="$env{ZRAMSIZE}"
    SUBSYSTEM=="block", KERNEL=="zram0", ACTION=="add", RUN+="${mkswap} /dev/%k", RUN+="${swapon} -p 30000 /dev/%k"
  '';

}
