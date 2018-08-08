{ config, lib, pkgs, ... }: {

  imports = [
    ./dbus
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
