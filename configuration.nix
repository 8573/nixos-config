# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{

  imports = [
    ./generic

    # ./installations/local should be a symlink to the directory for the
    # local system's Nixos installation.
    ./installations/local/configuration.nix

    ./secret/users.nix
  ];

}
