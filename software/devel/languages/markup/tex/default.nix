{
  id = "tex";
  desc = "software for working with TeX";
  global = true;
  sw = p: with p; [
    (texlive.combine {
      inherit (texlive)
        latexmk
        scheme-small
      ;
    })
    texmaker
  ];
}
