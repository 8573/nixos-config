# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... } @ args:

let

  # ./installations/local should be a symlink to the directory for the
  # local system's Nixos installation.

  local-installation = import ./installations/local/info.nix {
    inherit config lib pkgs;
    toplevel-args = args;
  };

  params = import ./params.nix {
    inherit config lib pkgs local-installation;
    toplevel-args = args;
    params = params // local-installation.params or {};
  };

in {

  imports = [
    ./installations/local/configuration.nix
    ./sections
    ./secret/users.nix
  ];

  environment.noXlibs = !params.use-X11;

  hardware.enableAllFirmware = params.enable-all-firmware;

  networking = {
    hostId = local-installation.id8;
    hostName = local-installation.id5;
  };

  # TODO: Determine how to pass around state like `params`, and move this to
  # the security section module.
  security.grsecurity = {
    enable = params.use-grsecurity;
  };

  services.xserver = {
    desktopManager = {
      default = if params.use-KDE then "kde5" else "none";
      kde5.enable = params.get-KDE;
      xterm.enable = false;
    };
    displayManager = {
      sddm.enable = config.services.xserver.enable;
    };
    windowManager = {
      default = if !params.use-KDE then "i3" else "none";
      i3.enable = params.get-i3;
    };
  };

}
