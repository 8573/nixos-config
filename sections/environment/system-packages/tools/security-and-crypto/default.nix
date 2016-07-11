{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    apg
    checksec
    gnupg
    openssl
  ]);

}
