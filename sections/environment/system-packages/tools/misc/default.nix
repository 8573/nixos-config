{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    aspell
    jq
    libqalculate
    wdiff
    wget
  ]);

}
