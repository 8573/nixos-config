{
  id = "Dwarf-Fortress";
  desc = "pre-configured virtual machine containing the game Dwarf Fortress";
  sw = p: with p; [
    (c74d.build-VM.basic ./pkg.nix)
  ];
}
