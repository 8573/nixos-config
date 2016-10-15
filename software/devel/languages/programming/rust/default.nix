{
  id = "rust";
  desc = "software for working with the programming language Rust";
  sw = p: with p; [
    cargo
    rustc
    rustfmt
    rustracer
  ];
}
