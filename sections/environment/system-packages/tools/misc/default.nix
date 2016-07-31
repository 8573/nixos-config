{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    aspell
    jq
    libqalculate
    wdiff
    wget
  ]) ++ [
    (config.lib.c74d.call-pkg "own/vim-pager" {
      vim = pkgs.vim_configurable;
    })
  ];

}
