{
  id = "pdf";
  desc = "PDF tools";
  sw = p: with p; [
    #pdfdiff
    pdftk
    poppler_utils
    qpdf
  ];
}
