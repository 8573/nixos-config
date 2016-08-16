{ config, lib, pkgs, ... } @ args: let

  call-pkg =
    lib.callPackageWith
      (lib.recursiveUpdate pkgs config.lib.c74d.pkgs);

in {

  lib.c74d.call-pkg = call-pkg;

  lib.c74d.pkgs = {

    c74d = import ./c74d args;

    # My vim-pager and vim-try-x (etc.) packages will see this version of Vim,
    # so I needn't override it for each of them.
    vim = config.programs.vim.package;

  };

}
