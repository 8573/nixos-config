{ config, lib, pkgs, ... }: {

  imports = [
    ./bash
    ./gnupg
    ./mosh
    ./ssh
    ./tmux
    ./vim
    ./zsh
  ];

}
