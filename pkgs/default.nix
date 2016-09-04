{ config, lib, pkgs, ... } @ args: let

  call-pkg =
    lib.callPackageWith
      (lib.recursiveUpdate pkgs config.lib.c74d.pkgs);

in {

  lib.c74d.call-pkg = call-pkg;

  lib.c74d.pkgs = {

    agrep = call-pkg ./agrep {};

    c74d = import ./c74d args;

    git-hub-ingydotnet = call-pkg ./git-hub-ingydotnet {};

    perlPackages = import ./perl-packages args;

    # My vim-pager and vim-try-x (etc.) packages will see this version of Vim,
    # so I needn't override it for each of them.
    vim = config.programs.vim.package;

    wrapped = import ./wrapped args;

  };

}
