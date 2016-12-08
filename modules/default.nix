{ config, lib, pkgs, ... }: {

  imports = [
    ./lib
    ./c74d-params
    ./programs
    ./services
  ];

}
