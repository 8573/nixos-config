{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    ldns
    telnet
    whois
  ]);

}
