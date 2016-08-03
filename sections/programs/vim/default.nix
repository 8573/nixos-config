{ config, lib, pkgs, ... }: {

  programs.vim = {
    enable = true;

    vimrc.text = ''
      source /etc/vim/vimrc
    '';

    plugins = [
      "sensible"
    ];
  };

}
