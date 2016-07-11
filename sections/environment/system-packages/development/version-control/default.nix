{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    gitAndTools.git-imerge
    gitFull
    subversion
    tig
  ]);

}
