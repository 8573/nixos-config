{ config, lib, pkgs, ... }: {

  imports = [
    ./bash
    ./dconf
    ./firejail
    ./mosh
    ./ssh
    ./tmux
    ./vim
    ./zsh
  ];

}
