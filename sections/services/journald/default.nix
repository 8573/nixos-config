{ config, lib, pkgs, ... }: {

  services.journald = {
    extraConfig = ''
      SystemMaxUse=128M
    '';
  };

}
