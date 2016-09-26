{ config, lib, pkgs, ... }: {

  imports = [
    ./c-family
    ./css
    ./javascript
    ./lisp
    ./nix
    ./rust
    ./shell-script
  ];

}
