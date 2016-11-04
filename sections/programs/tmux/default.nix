{ config, lib, pkgs, ... }: {

  imports = [
    ./personal.nix
  ];

  programs.tmux = {
    enable = true;

    clock24 = true;

    escapeTime = 125;

    historyLimit = 65536;

    terminal = "tmux-256color";

    extraTmuxConf = ''
      set-option -g mouse on
      set-option -g renumber-windows on
      set-option -g set-titles on
      set-option -g status-interval 1
      set-option -g status-left '[#{=16:socket_path} #{session_id} #{session_name}] '
      set-option -g status-left-length 40
      set-option -g status-right ' [#{session_attached}ac] [%F %T %Z] [#{host_short}]'
      set-option -g status-style "fg=white,bg=blue"

      set-window-option -g allow-rename off
      set-window-option -g xterm-keys on
    '';
  };

}
