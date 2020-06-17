{ config, lib, pkgs, ... }: {

  services.tmux = {
    # The automatically-started tmux doesn't seem to get tmux-resurrect for
    # some reason.
    #
    # [2020-06-17] I don't know whether that remains true, but I don't seem to
    # use tmux-resurrect anyway, so I'm re-enabling this.
    enable = config.c74d-params.personal;
  };

}
