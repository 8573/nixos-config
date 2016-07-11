{ config, lib, pkgs, ... }: {

  imports = [
    ./c-family
    ./javascript
    ./nix
    ./rust
    ./shell-script
  ];

}
