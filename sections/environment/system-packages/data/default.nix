{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    aspellDicts.en
    man-pages
    posix_man_pages
  ]);

}
