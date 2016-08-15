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

      (plugin-from-GitHub {
        owner = "bitc";
        repo = "vim-bad-whitespace";
        rev = "v0.3";
        sha256 = "1zxs47pvm217iijbv2jcd54hil2yxrg3jbz2k3nqzlcljl8bz8mn";
      })
    ];
  };

}
