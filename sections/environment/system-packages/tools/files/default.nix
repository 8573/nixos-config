{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    atool
    file
    rsync
    silver-searcher
    tree
  ]) ++ (with config.lib.c74d.pkgs; [
    agrep
  ]);

}
