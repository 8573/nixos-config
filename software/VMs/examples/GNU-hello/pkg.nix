# This is an example of a virtual machine configuration featuring a single
# program, GNU `hello`.

{ config, lib, pkgs, ... }: {

  networking.hostName = "GNU-hello-VM";

  c74d-params.id =
    "4f940d0019d8dbeef7d7dfe6dd9ee7e652cb9c6e0b86b98dca98863dfbfcb116";

  environment.systemPackages = with pkgs; [
    hello
  ];

}
