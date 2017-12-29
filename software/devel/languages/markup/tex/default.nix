{
  id = "tex";
  desc = "software for working with TeX";
  global = true;
  sw = p: with p; [
    (texlive.combine {
      inherit (texlive)
        collection-bibtexextra
        collection-binextra
        collection-fontsrecommended
        collection-latexextra
        collection-mathscience
        collection-pictures
        collection-plaingeneric
        scheme-small
      ;
    })
    biber
    texmaker
  ];
}
