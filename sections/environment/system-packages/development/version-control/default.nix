{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    git-lfs
    gitAndTools.git-imerge
    gitFull
    subversion
    tig
  ]);

}
