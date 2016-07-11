{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    gdb
    gnumake
    llvm
    llvmPackages.lldb
  ]);

}
