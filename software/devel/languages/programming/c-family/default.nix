{
  id = "c-family";
  desc = "software for working with programming languages in the C family";
  sw = p: with p; [
    (lib.hiPrio clang)
    gcc
  ];
}
