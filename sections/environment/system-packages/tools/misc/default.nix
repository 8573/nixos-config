{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    aspell
    jq
    libqalculate
    wdiff
    wget
  ]) ++ (with config.lib.c74d.pkgs; [
    c74d.vim-pager
  ]);

}
