{

  imports = [
    ./generic

    # ./installations/local should be a symlink to the directory for the
    # local system's Nixos installation.
    ./installations/local/configuration.nix
  ];

}
