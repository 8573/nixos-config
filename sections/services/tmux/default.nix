{ config, lib, pkgs, ... }: {

  services.tmux = {
    enable = config.c74d-params.personal;
  };

}
