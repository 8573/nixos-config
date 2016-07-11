{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    imagemagick
    libav
  ]);

}
