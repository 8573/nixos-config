{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    atool
    file
    silver-searcher
    tree
  ]);

}
