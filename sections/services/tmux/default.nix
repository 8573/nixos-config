{ config, lib, pkgs, ... }: {

  services.tmux = {
    # The automatically-started tmux doesn't seem to get tmux-resurrect for
    # some reason.
    enable = config.c74d-params.personal && false;
  };

}
