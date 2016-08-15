{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d.vim.utils)
    plugin-from-GitHub;

in {

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
