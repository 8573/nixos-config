{
  id = "examples";
  desc = "example pre-configured virtual machines";
  sw = p: map p.c74d.build-VM.basic [
    ./GNU-hello
    ./Dwarf-Fortress
  ];
}
