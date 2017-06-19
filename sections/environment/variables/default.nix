{ config, lib, pkgs, ... }: {

  imports = [
    ./personal
  ];

  environment.sessionVariables = {
    "TERMINFO" = "/run/current-system/sw/share/terminfo";
  };

}
