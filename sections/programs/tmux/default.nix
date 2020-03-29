{ config, lib, pkgs, ... }: let

  tmux-sensible = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-sensible";
    rev = "e91b178ff832b7bcbbf4d99d9f467f63fd1b76b5";
    sha256 = "1z8dfbwblrbmb8sgb0k8h1q0dvfdz7gw57las8nwd5gj6ss1jyvx";
  };

in {

  imports = [
    ./personal.nix
  ];

  programs.tmux = {
    enable = true;

    clock24 = true;

    terminal = "tmux-256color";

    extraConfig = ''
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

      run-shell ${tmux-sensible}/sensible.tmux
    '';
  };

}
