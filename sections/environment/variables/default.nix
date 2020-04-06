{ config, lib, pkgs, ... }: {

  imports = [
    ./personal
    ./rust.nix
  ];

  environment.sessionVariables = {
    "TERMINFO" = "${config.system.path}/share/terminfo";
  };

}
