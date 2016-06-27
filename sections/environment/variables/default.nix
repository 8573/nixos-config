{ config, lib, pkgs, ... }: {

  environment.variables = {
    EDITOR = lib.mkIf config.c74d-params.personal "vim";
  };

}
