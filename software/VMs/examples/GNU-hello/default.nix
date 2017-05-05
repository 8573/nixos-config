{
  id = "GNU-hello";
  desc = "pre-configured virtual machine containing the GNU 'Hello, world' program";
  sw = p: with p; [
    (c74d.build-VM.basic ./pkg.nix)
  ];
}
