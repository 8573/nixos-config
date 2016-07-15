{ config, lib, pkgs, ... }: {

  imports = [
    ./vimrc
    ./sensible
    ./spell
    ./filekinds
  ];

}
