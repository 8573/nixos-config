{
  id = "Dwarf-Fortress";
  desc = "Dwarf Fortress";
  sw = p: with p.dwarf-fortress-packages; [
    (dwarf-fortress-full.override {
      enableIntro = false;
      enableTruetype = false;
      enableFPS = true;
    })
  ];
}
