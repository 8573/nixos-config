{ config, lib, pkgs, ... }: {

  imports = [
    ./bash
    ./dconf
    ./mosh
    ./ssh
    ./tmux
    ./vim
    ./zsh
  ];

}
