{ config, lib, pkgs, ... } @ args: let

  inherit (config.lib.c74d)
    call-pkg;

in {

  build-VM = call-pkg ./build-VM {
    host-module-args = args;
  };

  tmux-open-piped-url = call-pkg ./tmux-open-piped-url {};

  vim-config = call-pkg ./vim-config {};

  vim-pager = call-pkg ./vim-pager {};

  vim-try-x = call-pkg ./vim-try-x {};

  with-rust = call-pkg ./with-rust {};

  zsh-config = call-pkg ./zsh-config {};

}
