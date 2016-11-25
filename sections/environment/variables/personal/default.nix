{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d.pkgs.c74d)
    vim-pager vim-try-x;

  visual-editor =
    if config.services.xserver.enable then
      "${vim-try-x}/bin/vim-try-x-nofork"
    else
      "${config.programs.vim.package}/bin/vim";

in {

  environment.variables = lib.mkIf config.c74d-params.personal {
    EDITOR = visual-editor;

    PAGER = "${vim-pager}/bin/vim-pager";

    MANPAGER = "${vim-pager}/bin/vim-manpager";

    VIMPAGER_VIM = "${vim-try-x}/bin/vim-try-x";

    VISUAL = visual-editor;
  };

}
