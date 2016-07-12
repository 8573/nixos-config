{ config, lib, pkgs, ... }: {

  programs.tmux = {
    enable = true;

    clock24 = true;

    escapeTime = 125;

    historyLimit = 65536;

    terminal = "screen-256color";

    extraTmuxConf = ''
      set-option -g mouse on
      set-option -g renumber-windows on
      set-option -g status-interval 1
      set-option -g status-left '[#{=16:socket_path} #{session_id} #{session_name}] '
      set-option -g status-left-length 40
      set-option -g status-right ' [%F %T %Z] [#{host_short}]'
      set-option -g status-style "fg=white,bg=blue"

      set-window-option -g allow-rename off
      set-window-option -g window-status-activity-style "fg=yellow,none"
      set-window-option -g window-status-bell-style "fg=red,none"
      set-window-option -g window-status-current-format '#I#F#W'
      set-window-option -g window-status-current-style "fg=green"
      set-window-option -g window-status-format '#I#F#W'
      set-window-option -g window-status-last-style "fg=cyan"
      set-window-option -g window-status-separator ' '
      set-window-option -g window-status-style "fg=cyan"
      set-window-option -g xterm-keys on

      bind-key C new-window -a
      bind-key C-C new-window -a -c '#{pane_current_path}'
    '';
  };

}
