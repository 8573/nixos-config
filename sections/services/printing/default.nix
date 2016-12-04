{ config, lib, pkgs, ... }: {

  services.printing = {
    enable = lib.elem config.c74d-params.installation-type [
      "desktop"
      "laptop"
    ];

    drivers = lib.mkIf config.services.printing.enable (with pkgs; [
      hplip
    ]);
  };

}
