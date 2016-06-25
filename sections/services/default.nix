{ config, lib, pkgs, ... }: {

  imports = [
    ./fail2ban
    ./gpm
    ./logind
    ./openssh
    ./printing
    ./redshift
    ./xserver
  ];

}
