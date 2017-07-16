{ config, lib, pkgs, ... }: {

  programs.gnupg = lib.mkIf config.c74d-params.GnuPG.services.enable {
    agent = {
      enable = true;
      enableSSHSupport = true;
    };

    dirmngr = {
      enable = true;
    };
  };

}
