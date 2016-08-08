{ config, lib, pkgs, ... }: {

  imports = [
    ./bash
    ./mosh
    ./ssh
    ./tmux
    ./vim
    ./zsh
  ];

}
