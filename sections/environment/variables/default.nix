{ config, lib, pkgs, ... }: {

  imports = [
    ./personal
  ];

  environment.sessionVariables = {
    "TERMINFO" = "${config.system.path}/share/terminfo";
  };

}
