{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    closurecompiler
    nodePackages.eslint
    nodejs
  ]);

}
