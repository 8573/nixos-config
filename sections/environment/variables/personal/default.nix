{ config, lib, pkgs, ... }: {

  environment.variables = lib.mkIf config.c74d-params.personal {
    EDITOR =
      if config.services.xserver.enable then
        "vim-try-x-nofork"
      else
        "vim";

    PAGER = "vim-pager";

    MANPAGER = "vim-manpager";
  };

}
