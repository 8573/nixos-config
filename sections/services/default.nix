{ config, lib, pkgs, ... }: {

  imports = [
    ./fail2ban
    ./gpm
    ./journald
    ./logind
    ./openssh
    ./printing
    ./redshift
    ./tmux
    ./udev
    ./xserver
    ./zfs
  ];

}
