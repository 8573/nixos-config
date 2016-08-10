{ config, lib, pkgs, ... }: {

  environment.variables = lib.mkIf config.c74d-params.personal {
    EDITOR = "vim";
    PAGER = "vim-pager";
  };

}
