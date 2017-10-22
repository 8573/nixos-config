{
  id = "tex";
  desc = "software for working with TeX";
  global = true;
  sw = p: with p; [
    texlive.combined.scheme-small
    texmaker
  ];
}
