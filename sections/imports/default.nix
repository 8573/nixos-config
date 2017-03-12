{ config, lib, pkgs, ... }: let

  cp = config.c74d-params;

in {

  imports =
    lib.optional
      (cp.VM.virtualization-type == "QEMU/KVM"
        && cp.installation-type != "VM" && false)
      <nixpkgs/nixos/modules/profiles/qemu-guest.nix>;

}
