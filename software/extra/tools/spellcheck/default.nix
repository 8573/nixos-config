{
  id = "spellcheck";
  desc = "spelling-checking tools";
  sw = p: with p; [
    aspell
    aspellDicts.en
  ];
}
