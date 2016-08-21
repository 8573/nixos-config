{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    call-pkg;

in {

  tmux-open-piped-url = call-pkg ./tmux-open-piped-url {};

  vim-config = call-pkg ./vim-config {};

  vim-pager = call-pkg ./vim-pager {};

  vim-try-x = call-pkg ./vim-try-x {};

  zsh-config = call-pkg ./zsh-config {};

}
