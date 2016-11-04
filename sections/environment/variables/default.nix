{ config, lib, pkgs, ... }: {

  imports = [
    ./personal
  ];

  environment.variables = {
    "TERMINFO" = "/run/current-system/sw/share/terminfo";
  };

}
