{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    closurecompiler
    nodejs
  ]);

}
