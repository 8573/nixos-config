{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    cargo
    rustc
    rustfmt
    rustracer
  ]);

}
