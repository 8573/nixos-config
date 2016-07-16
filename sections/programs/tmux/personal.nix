{ config, lib, pkgs, ... }: {

  programs.tmux = lib.mkIf config.c74d-params.personal {
    extraTmuxConf = ''
      set-option -g mode-keys vi
      set-option -g status-keys vi
    '';
  };

}
