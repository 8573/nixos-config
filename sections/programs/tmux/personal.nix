{ config, lib, pkgs, ... }: {

  programs.tmux = lib.mkIf config.c74d-params.personal {
    keyMode = "vi";

    extraTmuxConf = ''
      # For now I'm leaving Bash as the system's default login shell, but
      # within tmux I'll have it be zsh.
      set-option -g default-shell '/run/current-system/sw/bin/zsh'

      set-window-option -g window-status-activity-style "fg=yellow,none"
      set-window-option -g window-status-bell-style "fg=red,none"
      set-window-option -g window-status-current-format '#I#F#W'
      set-window-option -g window-status-current-style "fg=green"
      set-window-option -g window-status-format '#I#F#W'
      set-window-option -g window-status-last-style "fg=cyan"
      set-window-option -g window-status-separator ' '
      set-window-option -g window-status-style "fg=cyan"

      bind-key C new-window -a
      bind-key C-C new-window -a -c '#{pane_current_path}'
    '';
  };

}
