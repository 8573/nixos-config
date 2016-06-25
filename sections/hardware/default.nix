{ config, lib, pkgs, ... }: {

  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [
      hplip
    ];
  };

}
