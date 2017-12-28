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
        collection-genericrecommended
        collection-latexextra
        collection-mathextra
        collection-pictures
        scheme-small
      ;
    })
    biber
    texmaker
  ];
}
