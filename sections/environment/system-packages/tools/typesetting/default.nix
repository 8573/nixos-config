{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
  ]) ++ (with config.lib.c74d.pkgs; [
    perlPackages.Swim
  ]);

}
