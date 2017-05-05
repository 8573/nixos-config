# This is an example of a virtual machine configuration wrapping a game, Dwarf
# Fortress.

{ config, lib, pkgs, ... }: {

  networking.hostName = "Dwarf-Fortress-VM";

  c74d-params.id =
    "453d1a98b262374ba7d7728a37e07cf823a2ae232524453a6df42b1d2e56d3d9";

  # As computer games seem to often require.
  c74d-params.secure = false;

  c74d-params.X11.enable = true;

  environment.systemPackages = with pkgs.dwarf-fortress-packages; [
    (dwarf-fortress.override { enableDFHack = true; })
  ];

  nixpkgs.config.allowUnfree = true;

}
