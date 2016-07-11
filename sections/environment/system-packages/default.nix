{ config, lib, pkgs, ... }: {

  imports = [
    ./applications
    ./data
    ./development
    ./shells
    ./tools
  ];

}
