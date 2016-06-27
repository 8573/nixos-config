{ config, lib, pkgs, ... }: {

  services.printing = {
    enable = config.c74d-params.installation-type != "server";

    drivers = with pkgs; lib.optionals config.services.printing.enable [
      hplip
    ];
  };

}
