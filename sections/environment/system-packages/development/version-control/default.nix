{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    git-lfs
    gitAndTools.git-imerge
    gitFull
    subversion
    tig
  ]) ++ (with config.lib.c74d.pkgs; [
    git-hub-ingydotnet
  ]);

}
