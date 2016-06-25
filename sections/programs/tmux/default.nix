{ config, lib, pkgs, ... }: {

  programs.tmux = {
    enable = true;

    clock24 = true;

    historyLimit = 65536;

    terminal = "screen-256color";

    extraTmuxConf = ''
      set-option -g mouse on
      set-option -g renumber-windows on
      set-window-option -g allow-rename off
    '';
  };

}
