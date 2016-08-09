{ config, lib, pkgs, ... }: {

  imports = [
    ./personal
  ];

  programs.zsh = {
    enable = true;
  };

}
