{ config, lib, pkgs, ... }: {

  imports = [
    ./bash
    ./dconf
    ./emacs
    ./firejail
    ./mosh
    ./ssh
    ./tmux
    ./vim
    ./zsh
  ];

}
