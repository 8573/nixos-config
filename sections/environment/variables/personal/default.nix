{ config, lib, pkgs, ... }: let

  c74d-pkgs = config.lib.c74d.pkgs;

  visual-editor =
    if config.services.xserver.enable then
      "vim-try-x-nofork"
    else
      "vim";

in {

  environment.variables = lib.mkIf config.c74d-params.personal {
    EDITOR = visual-editor;

    PAGER = "vim-pager";

    MANPAGER = "vim-manpager";

    VIMPAGER_VIM = "${c74d-pkgs.c74d.vim-try-x}/bin/vim-try-x";

    VISUAL = visual-editor;
  };

}
