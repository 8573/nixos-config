{ config, lib, pkgs, ... }: {

  options.c74d-params.software.basic.tools.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = config.c74d-params.software.basic.enable;
    };

  config.environment.systemPackages = lib.mkIf
    config.c74d-params.software.basic.tools.enable
    ((with pkgs; [
      apg
      atool
      checksec
      file
      gnupg
      htop
      iotop
      jq
      (lib.getBin ldns)
      lshw
      lsscsi
      openssl
      pciutils
      rsync
      silver-searcher
      smartmontools
      tcpdump
      telnet
      tree
      usbutils
      wdiff
      wget
      whois
    ]) ++ (with config.lib.c74d.pkgs; [
      c74d.vim-pager
    ]));

}
