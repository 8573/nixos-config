{ config, ... }: {

  nixpkgs.overlays =
    import ./overlays.nix;

}
