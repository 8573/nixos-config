{
  id = "rust";
  desc = "software for working with the programming language Rust";
  modules = [
    ./global
  ];
  sw = p: with p; ([
    cargo
    rustc
    rustfmt
    rustracer
  ] ++ map (lib.getOutput "doc") [
    rustc
  ]);
}
