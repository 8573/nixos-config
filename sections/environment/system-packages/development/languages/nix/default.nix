{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    nix-prefetch-scripts
    nix-repl
  ]);

}
