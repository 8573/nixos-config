{ config, lib, pkgs, ... }: {

  services.printing = {
    enable = config.c74d-params.installation-type != "server";

    drivers = lib.mkIf config.services.printing.enable (with pkgs; [
      hplip
    ]);
  };

}
