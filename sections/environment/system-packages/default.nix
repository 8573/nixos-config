{ config, lib, pkgs, ... }: {

  imports = [
    ./applications
    ./development
    ./shells
  ];

}
