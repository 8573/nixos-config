{ config, lib, pkgs, ... }: let

  xclip = "${pkgs.xclip}/bin/xclip";

  zsh = "${config.system.path}/bin/zsh";

  tmux-resurrect = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-resurrect";
    rev = "dcef21995add18a50db8f7342824935e4826c39d";
    sha256 = "0hbvx27sn0a23s67niib8xx1i61s5m4dq35fxvzbdp84j8mm33j4";
  };

  tmux-continuum = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-continuum";
    rev = "90f4a00c41de094864dd4e29231253bcd80d4409";
    sha256 = "1hviqz62mnq5h4vgcy9bl5004q18yz5b90bnih0ibsna877x3nbc";
  };

in {

  programs.tmux = lib.mkIf config.c74d-params.personal {
    keyMode = "vi";

    extraTmuxConf = ''
      # For now I'm leaving Bash as the system's default login shell, but
      # within tmux I'll have it be zsh.
      set-option -g default-shell '${zsh}'

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

      bind-key w choose-window -F '#{?window_bell_flag,!, }#{?window_active,*,#{?window_last_flag,-, }}#{?window_silence_flag,~, }#{?window_zoomed_flag,Z, }#{?window_linked,L, } #{pane_current_path}  (#{pane_current_command}/#{pane_pid})'

      bind-key C-r split-window -v -b -l 5 env ZSHRC_EXIT_AFTER_FIRST_CMD_IF_OK=1 '${zsh}'

      bind-key -r < swap-window -t -1
      bind-key -r > swap-window -t +1

      bind-key -T copy-mode-vi u send-keys -X copy-pipe-and-cancel "${config.lib.c74d.pkgs.c74d.tmux-open-piped-url}"
      bind-key -T copy-mode-vi x send-keys -X copy-pipe-and-cancel "'${xclip}' -in -selection primary"
      bind-key -T copy-mode-vi X send-keys -X copy-pipe-and-cancel "'${xclip}' -in -selection clipboard"

      # While the duality between the standard bindings of `[` and `]` is
      # understandable, I've too often pressed `]` when meaning to press `[`
      # and pasted something by accident, which is inconvenient and
      # undesirable, so I'm unbinding `]` in favor of always using the
      # standard binding of `=` when I do mean to paste from a buffer.
      unbind-key ]

      set-option -g @resurrect-save 'S'
      set-option -g @resurrect-restore 'R'

      set-option -g @continuum-restore 'on'
      set-option -g @continuum-save-interval '60'

      run-shell ${tmux-resurrect}/resurrect.tmux
      run-shell ${tmux-continuum}/continuum.tmux
    '';
  };

  systemd.tmpfiles.rules = [
    "r /home/*/.tmux/resurrect/* - - - 1w"
  ];

}
