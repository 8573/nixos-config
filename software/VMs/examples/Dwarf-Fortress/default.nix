# This is an example of a virtual machine configuration wrapping a game, Dwarf
# Fortress.

{ config, lib, pkgs, ... }: {

  networking.hostName = "Dwarf-Fortress-VM";

  c74d-params.id =
    "453d1a98b262374ba7d7728a37e07cf823a2ae232524453a6df42b1d2e56d3d9";

  c74d-params.X11.enable = true;

  environment.systemPackages = with pkgs; [
    dwarf-fortress
  ];

  nixpkgs.config.allowUnfree = true;

}
