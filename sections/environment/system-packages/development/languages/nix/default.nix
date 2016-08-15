{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    nix-generate-from-cpan
    nix-prefetch-scripts
    nix-repl
  ]);

}
