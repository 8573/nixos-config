{
  id = "Dwarf-Fortress";
  desc = "Dwarf Fortress";
  sw = p: with p.dwarf-fortress-packages; [
    (dwarf-fortress.override { enableDFHack = true; })
  ];
}
