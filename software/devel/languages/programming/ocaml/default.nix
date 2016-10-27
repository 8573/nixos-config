{
  id = "ocaml";
  desc = "software for working with OCaml";
  default = false;
  sw = p: with p.ocamlPackages; [
    utop
  ];
}
