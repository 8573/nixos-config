{ config, lib, pkgs, ... }: {

  programs.vim = {
    enable = true;

    plugins = [
      "sensible"
    ];
  };

}
